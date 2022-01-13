// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import {ROBINHOOD} from "./Mint.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function burn(uint256 amount) external;

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

interface IUniswapV2Factory {
    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);
}

interface IUniswapV2Pair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to)
        external
        returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        if (b > a) return (false, 0);
        return (true, a - b);
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo by zero");
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        return a - b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryDiv}.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a % b;
    }
}

library UniswapV2Library {
    using SafeMath for uint256;

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB)
        internal
        pure
        returns (address token0, address token1)
    {
        require(tokenA != tokenB, "UniswapV2Library: IDENTICAL_ADDRESSES");
        (token0, token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);
        require(token0 != address(0), "UniswapV2Library: ZERO_ADDRESS");
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(
        address factory,
        address tokenA,
        address tokenB
    ) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(
            uint256(
                keccak256(
                    abi.encodePacked(
                        hex"ff",
                        factory,
                        keccak256(abi.encodePacked(token0, token1)),
                        hex"96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f" // init code hash
                    )
                )
            )
        );
    }

    // fetches and sorts the reserves for a pair
    function getReserves(
        address factory,
        address tokenA,
        address tokenB
    ) internal view returns (uint256 reserveA, uint256 reserveB) {
        (address token0, ) = sortTokens(tokenA, tokenB);
        (uint256 reserve0, uint256 reserve1, ) = IUniswapV2Pair(
            pairFor(factory, tokenA, tokenB)
        ).getReserves();
        (reserveA, reserveB) = tokenA == token0
            ? (reserve0, reserve1)
            : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) internal pure returns (uint256 amountB) {
        require(amountA > 0, "UniswapV2Library: INSUFFICIENT_AMOUNT");
        require(
            reserveA > 0 && reserveB > 0,
            "UniswapV2Library: INSUFFICIENT_LIQUIDITY"
        );
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) internal pure returns (uint256 amountOut) {
        require(amountIn > 0, "UniswapV2Library: INSUFFICIENT_INPUT_AMOUNT");
        require(
            reserveIn > 0 && reserveOut > 0,
            "UniswapV2Library: INSUFFICIENT_LIQUIDITY"
        );
        uint256 amountInWithFee = amountIn.mul(997);
        uint256 numerator = amountInWithFee.mul(reserveOut);
        uint256 denominator = reserveIn.mul(1000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) internal pure returns (uint256 amountIn) {
        require(amountOut > 0, "UniswapV2Library: INSUFFICIENT_OUTPUT_AMOUNT");
        require(
            reserveIn > 0 && reserveOut > 0,
            "UniswapV2Library: INSUFFICIENT_LIQUIDITY"
        );
        uint256 numerator = reserveIn.mul(amountOut).mul(1000);
        uint256 denominator = reserveOut.sub(amountOut).mul(997);
        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    function getAmountsOut(
        address factory,
        uint256 amountIn,
        address[] memory path
    ) internal view returns (uint256[] memory amounts) {
        require(path.length >= 2, "UniswapV2Library: INVALID_PATH");
        amounts = new uint256[](path.length);
        amounts[0] = amountIn;
        for (uint256 i; i < path.length - 1; i++) {
            (uint256 reserveIn, uint256 reserveOut) = getReserves(
                factory,
                path[i],
                path[i + 1]
            );
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    function getAmountsIn(
        address factory,
        uint256 amountOut,
        address[] memory path
    ) internal view returns (uint256[] memory amounts) {
        require(path.length >= 2, "UniswapV2Library: INVALID_PATH");
        amounts = new uint256[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint256 i = path.length - 1; i > 0; i--) {
            (uint256 reserveIn, uint256 reserveOut) = getReserves(
                factory,
                path[i - 1],
                path[i]
            );
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
}

contract RobinHoodMarketplace {
    ROBINHOOD public robinNFT;
    IUniswapV2Router02 public router;
    address public token;
    address public weth;
    address public factory;
    address public usdt;
    address public swapRouter = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private marketWallet;
    address private teamWallet;

    event NFTBuy(address owner, address operator);
    event Liquiditied(
        uint256 token,
        uint256 ETH,
        uint256 liquidity,
        uint256 time
    );
    event Swapped(uint256 token, uint256 ETH, uint256 time);

    struct NFTMarketData {
        uint256 tokenID;
        uint256 price;
        bool marketStatus; // false : Cancel, true : Open
        bool existance;
        uint256 currency;
    }

    struct RobinHood {
        ROBINHOOD.ItemNFT baseInfo;
        NFTMarketData marketInfo;
    }

    mapping(uint256 => NFTMarketData) private _robinData;
    uint256 private swapLimit = 100000000000;
    uint256 private liqTokenLimit = 100000000000;

    constructor(
        ROBINHOOD _robinNFT,
        address _teamWallet,
        address _marketWallet,
        address _token
    ) public {
        robinNFT = ROBINHOOD(_robinNFT);
        teamWallet = _teamWallet;
        marketWallet = _marketWallet;
        token = _token;

        router = IUniswapV2Router02(swapRouter);
        weth = router.WETH();
        factory = router.factory();
    }

    /**
     * @dev Opens a trade by the seller.
     */

    function openTradeWithToken(uint256 _nftID, uint256 price) public {
        require(
            msg.sender == robinNFT.ownerOf(_nftID),
            "Message Sender should be the owner of token"
        );
        _addDataIfNotExist(_nftID);
        IERC20(token).transferFrom(
            msg.sender,
            address(this),
            (price * 70) / 100
        );
        IERC20(token).transferFrom(
            msg.sender,
            marketWallet,
            (price * 10) / 100
        );
        IERC20(token).transferFrom(msg.sender, teamWallet, (price * 20) / 100);
        _robinData[_nftID].marketStatus = true;
        _robinData[_nftID].price = price * 10;
        _robinData[_nftID].currency = 0;
        addLiquidity();
        swap();
    }

    function openTradeWithBNB(uint256 _nftID) public payable {
        require(
            msg.sender == robinNFT.ownerOf(_nftID),
            "Message Sender should be the owner of token"
        );
        _addDataIfNotExist(_nftID);
        uint256 price = msg.value;
        payable(marketWallet).transfer((price * 10) / 100);
        payable(teamWallet).transfer((price * 20) / 100);
        _robinData[_nftID].marketStatus = true;
        _robinData[_nftID].price = price * 10;
        _robinData[_nftID].currency = 1;
        addLiquidity();
        swap();
    }

    function closeTradeWithToken(uint256 _nftID, uint256 price) public {
        require(
            msg.sender == robinNFT.ownerOf(_nftID),
            "Message Sender should be the owner of token"
        );
        NFTMarketData memory nftMarketData = _robinData[_nftID];
        uint256 buyAmount = nftMarketData.price;
        require(
            price == buyAmount / 10,
            "msg.value should be equal to the buyAmount"
        );
        IERC20(token).transferFrom(
            msg.sender,
            address(this),
            (price * 70) / 100
        );
        IERC20(token).transferFrom(
            msg.sender,
            marketWallet,
            (price * 10) / 100
        );
        IERC20(token).transferFrom(msg.sender, teamWallet, (price * 20) / 100);
        robinNFT.cancelTrade(_nftID);
        _robinData[_nftID].marketStatus = false;
        addLiquidity();
        swap();
    }

    function closeTradeWithBNB(uint256 _nftID) public payable {
        require(
            msg.sender == robinNFT.ownerOf(_nftID),
            "Message Sender should be the owner of token"
        );
        NFTMarketData memory nftMarketData = _robinData[_nftID];
        uint256 buyAmount = nftMarketData.price;
        uint256 price = msg.value;
        require(
            price == buyAmount / 10,
            "msg.value should be equal to the buyAmount"
        );
        payable(marketWallet).transfer((price * 5 * 10) / 100);
        payable(teamWallet).transfer((price * 5 * 20) / 100);
        robinNFT.cancelTrade(_nftID);
        _robinData[_nftID].marketStatus = false;
        addLiquidity();
        swap();
    }

    function _addDataIfNotExist(uint256 nftID) private {
        if (_robinData[nftID].existance == true) return;
        _robinData[nftID] = NFTMarketData({
            tokenID: nftID,
            price: 0,
            marketStatus: false,
            existance: true,
            currency: 0
        });
    }

    function getNFTItem(uint256 index) public view returns (RobinHood memory) {
        RobinHood memory robinData = RobinHood({
            baseInfo: robinNFT.getItem(index),
            marketInfo: _robinData[index]
        });

        return robinData;
    }

    function getAllNFTs() public view returns (RobinHood[] memory) {
        RobinHood[] memory result = new RobinHood[](robinNFT.lastNFTId());
        for (uint256 i = 0; i < robinNFT.lastNFTId(); i++) {
            result[i] = getNFTItem(i);
        }
        return result;
    }

    function buyNFTWithToken(uint256 tokenId, uint256 price) public {
        address buyer = msg.sender;
        address seller = robinNFT.ownerOf(tokenId); // Owner
        NFTMarketData memory nftMarketData = _robinData[tokenId];
        uint256 buyAmount = nftMarketData.price;

        require(
            price == buyAmount,
            "Token amount should be equal with the NFT price"
        );
        IERC20(token).transferFrom(buyer, seller, (price * 95) / 100);
        IERC20(token).transferFrom(
            buyer,
            address(this),
            (price * 5 * 70) / 100 / 100
        );
        IERC20(token).transferFrom(
            buyer,
            marketWallet,
            (price * 5 * 10) / 100 / 100
        );
        IERC20(token).transferFrom(
            buyer,
            teamWallet,
            (price * 5 * 20) / 100 / 100
        );
        // transfer ownership
        robinNFT.transferFrom(seller, buyer, tokenId);
        _robinData[tokenId].marketStatus = false;
        _robinData[tokenId].price = 0;
        robinNFT.cancelTrade(tokenId);
        addLiquidity();
        swap();
    }

    function buyNFTWithBNB(uint256 tokenId) public payable {
        address buyer = msg.sender;
        address seller = robinNFT.ownerOf(tokenId); // Owner
        NFTMarketData memory nftMarketData = _robinData[tokenId];
        uint256 buyAmount = nftMarketData.price;
        uint256 price = msg.value;
        if (_robinData[tokenId].currency == 0) {
            payable(seller).transfer((price * 95) / 100 / 2);
            payable(marketWallet).transfer((price * 5 * 10) / 100 / 100 / 2);
            payable(teamWallet).transfer((price * 5 * 20) / 100 / 100 / 2);
            swapETHForToken(buyAmount);
            _robinData[tokenId].currency = 1;
        } else {
            require(
                price == buyAmount,
                "BNB amount should be equal with the NFT price"
            );
            payable(seller).transfer((price * 95) / 100);
            payable(marketWallet).transfer((price * 5 * 10) / 100 / 100);
            payable(teamWallet).transfer((price * 5 * 20) / 100 / 100);
        }
        robinNFT.transferFrom(seller, buyer, tokenId);
        _robinData[tokenId].marketStatus = false;
        _robinData[tokenId].price = 0;
        robinNFT.cancelTrade(tokenId);
        addLiquidity();
        swap();
    }

    function setSwapLimit(uint256 _limit) public {
        swapLimit = _limit;
    }

    function getSwapLimit() public view returns (uint256) {
        return swapLimit;
    }

    function setLiqTokenLimit(uint256 _limit) public {
        liqTokenLimit = _limit;
    }

    function getLiqTokenLimit() public view returns (uint256) {
        return liqTokenLimit;
    }

    function swap() private {
        if (IUniswapV2Factory(factory).getPair(token, weth) != address(0)) {
            address[] memory path = new address[](2);
            path[0] = token;
            path[1] = weth;
            if (IERC20(token).balanceOf(address(this)) >= swapLimit) {
                IERC20(token).approve(swapRouter, swapLimit);
                uint256[] memory result = router.swapExactTokensForETH(
                    swapLimit,
                    0,
                    path,
                    address(this),
                    block.timestamp
                );
                emit Swapped(result[0], result[1], block.timestamp);
            }
        }
    }

    function addLiquidity() private {
        if (IUniswapV2Factory(factory).getPair(token, weth) != address(0)) {
            (uint256 reserveA, uint256 reserveB) = UniswapV2Library.getReserves(
                factory,
                token,
                weth
            );
            uint256 liqETHLimit = UniswapV2Library.quote(
                liqTokenLimit,
                reserveA,
                reserveB
            );
            if (
                address(this).balance > liqETHLimit &&
                IERC20(token).balanceOf(address(this)) > liqTokenLimit
            ) {
                IERC20(token).approve(swapRouter, liqTokenLimit);
                (
                    uint256 amountToken,
                    uint256 amountETH,
                    uint256 liquidity
                ) = router.addLiquidityETH{value: liqETHLimit}(
                        token,
                        liqTokenLimit,
                        liqTokenLimit,
                        liqETHLimit,
                        address(this),
                        block.timestamp
                    );
                emit Liquiditied(
                    amountToken,
                    amountETH,
                    liquidity,
                    block.timestamp
                );
            }
        }
    }

    function calculateBNB(uint256 amountIn) public view returns (uint256) {
        address[] memory path = new address[](2);
        path[0] = usdt;
        path[1] = weth;
        uint256[] memory amounts = router.getAmountsIn(amountIn, path);
        return amounts[1];
    }

    function swapETHForToken(uint256 amountOut) private {
        address[] memory path = new address[](2);
        path[0] = weth;
        path[1] = token;
        if (IUniswapV2Factory(factory).getPair(token, weth) != address(0)) {
            uint256[] memory amounts = router.getAmountsIn(amountOut, path);
            if (address(this).balance > amounts[0]) {
                uint256[] memory result = router.swapETHForExactTokens{
                    value: amounts[0]
                }(amountOut, path, address(this), block.timestamp);
                IERC20(token).burn(result[1]);
            }
        }
    }

    receive() external payable {}
}
