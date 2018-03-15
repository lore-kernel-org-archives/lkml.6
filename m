Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeCORaq convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:30:46 -0400
Received: from mx6-out9.antispamcloud.com ([95.211.2.200]:55120 "EHLO
        mx6-out9.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751897AbeCORao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:30:44 -0400
Subject: Re: [PATCH] clk: Add driver for the si544 clock generator chip
To: Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@01.org>
CC: <kbuild-all@01.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
References: <20180315103517.qkdqagrasoogp3yj@mwanda>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <846a65b6-0a4e-7f64-d421-840573917630@topic.nl>
Date: Thu, 15 Mar 2018 12:05:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315103517.qkdqagrasoogp3yj@mwanda>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: nl
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.80.121]
X-EXCLAIMER-MD-CONFIG: 9833cda7-5b21-4d34-9a38-8d025ddc3664
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Originating-IP: 37.74.225.130
X-AntiSpamCloud-Domain: topic.nl
X-AntiSpamCloud-Username: 37.74.225.128/28
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=37.74.225.128/28@topic.nl
X-AntiSpamCloud-Outgoing-Class: ham
X-AntiSpamCloud-Outgoing-Evidence: SB/global_tokens (0.00428691321046)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5o5dbtXj8wPAh9E24BFo3RF602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOySBiUVAo7M+WU0lEyRRks5TYi2bf0F0JzgUQ/o6tR7CC1AYAGOq49GTt3DaYiAGXuNf
 vx/q3++EaOm0N9CoCHDEZWNF11+ZJ4abW9525KP/NLrIDv4bW2jfYvuebDqf0a27L+vUIKBNb7s4
 mLCDP0OJjUpMyZY4NUqY4qGGCC0hpXWyRo+mRGYjs7LGYri8cQSm4RlC2Rqk8PAqZBWHDBgsKtg6
 LMm+mjN7pxNRp3bf5T6BABJDQfll18ke6DoBD5cJb1SSaSSOnP/GLBbOqj//gbuP7hnUK8NQdLws
 VWKIgoJFymS3UArvG7Mt1nxIqhIMY35MVYqHscKiMS+AJQwNoYkVbhZSPkZJaDp+CfVLjcKgOhRT
 QQL9GDYS/E/m1OPhyWebb+N99NBja8IpsJ4i1z4ChY8TEKkphxe4rPAbVgW9/bktU41htiJ8fk7N
 kP6tkLPzwYJwU+8gSzAgISnZYYyci0Xki6sLZG/ZNFHSqNiTliS0PDsdAKikX/ioBWWgh46j8OAz
 pUvQWS9gB0trOss7NUvZybW/6dRO2FcTFD9v7X0vaEkQphQ6oa0tsVbX6fV9WQXIWcL8fGu3U1Gt
 6gZ0TcbKOVFn6aWnPASXiWqdeZAqB4qJuPhKIbAjSAc8I07FTFcjpdfX/Jcr87dRCJY2lvOKBkoO
 ppxy3fOi6/OmPRUK4/eIf+NH7fx4Vc1yBdcxhoZB4YpYPbJxM3DB4h9p+XQ1KFTNP+6zxsVM5Svt
 7esqC5XX/vlALi5Gnyk4xAm9D8KTeKJT7gNACPcz7Z8yPl8tSzfV4CjV2lZlLoIFSDFtk1+cCnYO
 azfKM5/RIECHN/AjR8HFVkOX+8zACqiVQwGjEo1bIX5/jq93au6xsPX5U6xhfnOjcBLG1zEzgt+8
 KxlS9G1iPUOBuNSyYKHyKH71JGngUYUtaC1W0wD66TOuMt7aHBKZqOUCWPauc4nUxCofIHcodDN/
 7hnbnj+5TDYqwrr7oiNQWg/8mHXFUqLNg6IU+AH3gHbXXV3BDm4AHl4dGnO9CaDXurhvqH9WEtpY
 fVqr1z/WPPmZTPI3niUsrRv1n/PK9pAbm05kG5R+mZTJM5oqPBuw7jHGO1S3Ff9nDRYAmIg9S/la
 fwacQFjgWdoyX4Li/mLNGmvDK3PKrieG7T6bf9hS7hSIOpRc+mv1ciFLDD/7gtnL158VN0kmuHTv
 LuDBpkdJCd9f+zFF4ztRRN1wZ2s4laU=
X-Report-Abuse-To: spam@quarantine2.antispamcloud.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿On 15-03-18 11:35, Dan Carpenter wrote:
> Hi Mike,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on v4.16-rc4]
> [also build test WARNING on next-20180314]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Mike-Looijmans/clk-Add-driver-for-the-si544-clock-generator-chip/20180314-122736
> 
> smatch warnings:
> drivers/clk/clk-si544.c:188 si544_calc_muldiv() warn: impossible condition '((frequency * tmp) >= 10800000000) => (0-u32max >= 10800000000)'

Indeed, there's a u64 cast missing.

I've also missed that the hs_div cannot be odd when ls_div is non-zero.

I'll compose a v2 patch fixing these issues.

> # https://github.com/0day-ci/linux/commit/aba3d3de8751c1457bcf0b75bcc901f289a18426
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout aba3d3de8751c1457bcf0b75bcc901f289a18426
> vim +188 drivers/clk/clk-si544.c
> 
> aba3d3de Mike Looijmans 2018-03-13  168
> aba3d3de Mike Looijmans 2018-03-13  169  /* Calculate divider settings for a given frequency */
> aba3d3de Mike Looijmans 2018-03-13  170  static int si544_calc_muldiv(struct clk_si544_muldiv *settings,
> aba3d3de Mike Looijmans 2018-03-13  171  	unsigned long frequency)
> aba3d3de Mike Looijmans 2018-03-13  172  {
> aba3d3de Mike Looijmans 2018-03-13  173  	u64 vco;
> aba3d3de Mike Looijmans 2018-03-13  174  	u32 ls_freq;
> aba3d3de Mike Looijmans 2018-03-13  175  	u32 tmp;
> aba3d3de Mike Looijmans 2018-03-13  176  	u8 res;
> aba3d3de Mike Looijmans 2018-03-13  177
> aba3d3de Mike Looijmans 2018-03-13  178  	/* Determine the minimum value of LS_DIV and resulting target freq. */
> aba3d3de Mike Looijmans 2018-03-13  179  	ls_freq = frequency;
> aba3d3de Mike Looijmans 2018-03-13  180  	settings->ls_div_bits = 0;
> aba3d3de Mike Looijmans 2018-03-13  181
> aba3d3de Mike Looijmans 2018-03-13  182  	if (frequency >= (FVCO_MIN / HS_DIV_MAX))
> aba3d3de Mike Looijmans 2018-03-13  183  		settings->ls_div_bits = 0;
> aba3d3de Mike Looijmans 2018-03-13  184  	else {
> aba3d3de Mike Looijmans 2018-03-13  185  		res = 1;
> aba3d3de Mike Looijmans 2018-03-13  186  		tmp = 2 * HS_DIV_MAX;
> aba3d3de Mike Looijmans 2018-03-13  187  		while (tmp <= (HS_DIV_MAX * 32)) {
> aba3d3de Mike Looijmans 2018-03-13 @188  			if ((frequency * tmp) >= FVCO_MIN)
> aba3d3de Mike Looijmans 2018-03-13  189  				break;
> aba3d3de Mike Looijmans 2018-03-13  190  			++res;
> aba3d3de Mike Looijmans 2018-03-13  191  			tmp <<= 1;
> aba3d3de Mike Looijmans 2018-03-13  192  		}
> aba3d3de Mike Looijmans 2018-03-13  193  		settings->ls_div_bits = res;
> aba3d3de Mike Looijmans 2018-03-13  194  		ls_freq = frequency << res;
> aba3d3de Mike Looijmans 2018-03-13  195  	}
> aba3d3de Mike Looijmans 2018-03-13  196
> aba3d3de Mike Looijmans 2018-03-13  197  	/* Determine minimum HS_DIV by rounding up */
> aba3d3de Mike Looijmans 2018-03-13  198  	vco = FVCO_MIN + ls_freq - 1;
> aba3d3de Mike Looijmans 2018-03-13  199  	do_div(vco, ls_freq);
> aba3d3de Mike Looijmans 2018-03-13  200  	settings->hs_div = vco;
> aba3d3de Mike Looijmans 2018-03-13  201  	/* round up to even number if needed */
> aba3d3de Mike Looijmans 2018-03-13  202  	if ((settings->hs_div > HS_DIV_MAX_ODD) && (settings->hs_div & 1))
> aba3d3de Mike Looijmans 2018-03-13  203  		++settings->hs_div;
> aba3d3de Mike Looijmans 2018-03-13  204  	/* Calculate VCO frequency (in 10..12GHz range) */
> aba3d3de Mike Looijmans 2018-03-13  205  	vco = (u64)ls_freq * settings->hs_div;
> aba3d3de Mike Looijmans 2018-03-13  206  	/* Calculate the integer part of the feedback divider */
> aba3d3de Mike Looijmans 2018-03-13  207  	tmp = do_div(vco, FXO);
> aba3d3de Mike Looijmans 2018-03-13  208  	settings->fb_div_int = vco;
> aba3d3de Mike Looijmans 2018-03-13  209  	/* And the fractional bits using the remainder */
> aba3d3de Mike Looijmans 2018-03-13  210  	vco = (u64)tmp << 32;
> aba3d3de Mike Looijmans 2018-03-13  211  	do_div(vco, FXO);
> aba3d3de Mike Looijmans 2018-03-13  212  	settings->fb_div_frac = vco;
> aba3d3de Mike Looijmans 2018-03-13  213
> aba3d3de Mike Looijmans 2018-03-13  214  	return 0;
> aba3d3de Mike Looijmans 2018-03-13  215  }
> aba3d3de Mike Looijmans 2018-03-13  216
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
