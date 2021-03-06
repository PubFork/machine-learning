function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
% nn_params = [Theta1(:) ; Theta2(:)];                               
                               
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
% Theta1现在是25x401的矩阵
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
% Theta2现在是10x26的矩阵
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
X = [ones(m,1) X];

% 先计算所有的输出
hidden = sigmoid(X*Theta1');
output = sigmoid([ones(m,1) hidden]*Theta2');

% 计算出最后一层的输出之后，计算cost（没有求和以及/m操作）
yk = zeros(m,num_labels);       %yk代表的是[y==1 y=2 ... y==k],k为输出层节点个数
for i=1:num_labels
   yk(:,i) = y==i;
end
cost = yk.*log(output) + (ones(m,num_labels)-yk).*log(ones(m,num_labels)-output);

% 计算J
J = (-1/m) * sum(cost(:));

% 进行正则化
reg1 = Theta1(:,2:size(Theta1,2)).*Theta1(:,2:size(Theta1,2));
reg2 = Theta2(:,2:size(Theta2,2)).*Theta2(:,2:size(Theta2,2));
regular = (sum(reg1(:)) + sum(reg2(:))) * lambda/(2*m);

% 计算正则化之后的J
J = J + regular;        

% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
a_1 = X;
z_2 = a_1*Theta1';
a_2 = sigmoid(z_2);
z_3 = [ones(m,1) a_2]*Theta2';
a_3 = sigmoid(z_3);

delta_3 = a_3 - yk;
delta_2 = delta_3*Theta2.*sigmoidGradient([ones(m,1) z_2]);
delta_2 = delta_2(:,2:end);

Theta1_grad = (1/m) * (Theta1_grad + delta_2'*a_1);
Theta2_grad = (1/m) * (Theta2_grad + delta_3'*[ones(m,1) a_2]);

% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
% -------------------------------------------------------------
gradReg1 = (lambda/m)*Theta1(:,2:end);
gradReg2 = (lambda/m)*Theta2(:,2:end);

Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + gradReg1;
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + gradReg2;
% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
