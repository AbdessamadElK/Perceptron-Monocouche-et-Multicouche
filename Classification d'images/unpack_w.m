function [W1, W2] = unpack_w(nn_params, nbr_in, nbr_cach, nbr_out)
W1 = reshape(nn_params(1:nbr_cach * (nbr_in + 1)), ...
                 nbr_cach, (nbr_in + 1));

W2 = reshape(nn_params((1 + (nbr_cach * (nbr_in + 1))):end), ...
                 nbr_out, (nbr_cach + 1));
end