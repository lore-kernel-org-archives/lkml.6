Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756532AbeEASnx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:43:53 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37939 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756438AbeEASnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:43:51 -0400
X-Google-Smtp-Source: AB8JxZp1TIVR42NcsgSY0jBTqnzxLnKtKHZn5Mx/85Q5fxWkIA0XbWwX4NZve7RWRtgsvG6kpxE8Pw==
Subject: Re: [RFC net-next 4/5] net: phy: Add support for IEEE standard test
 modes
To: Woojung.Huh@microchip.com, netdev@vger.kernel.org
Cc: andrew@lunn.ch, rmk@armlinux.org.uk, linux-kernel@vger.kernel.org,
        davem@davemloft.net, cphealy@gmail.com,
        nikita.yoush@cogentembedded.com, vivien.didelot@savoirfairelinux.com,
        Nisar.Sayed@microchip.com, UNGLinuxDriver@microchip.com
References: <20180428003237.1536-1-f.fainelli@gmail.com>
 <20180428003237.1536-5-f.fainelli@gmail.com>
 <9235D6609DB808459E95D78E17F2E43D40D553D5@CHN-SV-EXMX02.mchp-main.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <66f30fca-f485-7f52-7441-3c8cf1718640@gmail.com>
Date: Tue, 1 May 2018 11:43:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9235D6609DB808459E95D78E17F2E43D40D553D5@CHN-SV-EXMX02.mchp-main.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2018 10:29 AM, Woojung.Huh@microchip.com wrote:
> Hi Florian,
> 
>> diff --git a/drivers/net/phy/phy-tests.c b/drivers/net/phy/phy-tests.c
> ...
>> +/* genphy_set_test - Make a PHY enter one of the standard IEEE defined
>> + * test modes
>> + * @phydev: the PHY device instance
>> + * @test: the desired test mode
>> + * @data: test specific data (none)
>> + *
>> + * This function makes the designated @phydev enter the desired standard
>> + * 100BaseT2 or 1000BaseT test mode as defined in IEEE 802.3-2012 section TWO
>> + * and THREE under 32.6.1.2.1 and 40.6.1.1.2 respectively
>> + */
>> +int genphy_set_test(struct phy_device *phydev,
>> +		    struct ethtool_phy_test *test, const u8 *data)
>> +{
>> +	u16 shift, base, bmcr = 0;
>> +	int ret;
>> +
>> +	/* Exit test mode */
>> +	if (test->mode == PHY_STD_TEST_MODE_NORMAL) {
>> +		ret = phy_read(phydev, MII_CTRL1000);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		ret &= ~GENMASK(15, 13);
>> +
>> +		return phy_write(phydev, MII_CTRL1000, ret);
>> +	}
>> +
>> +	switch (test->mode) {
>> +	case PHY_STD_TEST_MODE_100BASET2_1:
>> +	case PHY_STD_TEST_MODE_100BASET2_2:
>> +	case PHY_STD_TEST_MODE_100BASET2_3:
>> +		if (!(phydev->supported & PHY_100BT_FEATURES))
>> +			return -EOPNOTSUPP;
>> +
>> +		shift = 14;
>> +		base = test->mode - PHY_STD_TEST_MODE_NORMAL;
>> +		bmcr = BMCR_SPEED100;
>> +		break;
>> +
>> +	case PHY_STD_TEST_MODE_1000BASET_1:
>> +	case PHY_STD_TEST_MODE_1000BASET_2:
>> +	case PHY_STD_TEST_MODE_1000BASET_3:
>> +	case PHY_STD_TEST_MODE_1000BASET_4:
>> +		if (!(phydev->supported & PHY_1000BT_FEATURES))
>> +			return -EOPNOTSUPP;
>> +
>> +		shift = 13;
>> +		base = test->mode - PHY_STD_TEST_MODE_100BASET2_MAX;
>> +		bmcr = BMCR_SPEED1000;
>> +		break;
>> +
>> +	default:
>> +		/* Let an upper driver deal with additional modes it may
>> +		 * support
>> +		 */
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	/* Force speed and duplex */
>> +	ret = phy_write(phydev, MII_BMCR, bmcr | BMCR_FULLDPLX);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Set the desired test mode bit */
>> +	return phy_write(phydev, MII_CTRL1000, (test->mode + base) << shift);
>> +}
> For now, these are for 100B-T2 & 1000B-TX.
> But, other speeds such as 802.3bw/bq/cq have very similar format,
> how about make  phy_write() to BMCR & CTRL1000 as another function call per speed?

Not sure I completely understand your suggestion, do you mean that I
should break down the body of that function above such that there are
per-speed lower level functions? Something like the pseudo-code below:

genphy_set_test() {
	switch (mode) {
	case PHY_STD_TEST_MODE_100BASET2_1:
	..
	case PHY_STD_TEST_MODE_100BASET2_3:
		return genphy_set_100baset2();

	case PHY_STD_TEST_MODE_1000BASET_1:
	..
	case PHY_STD_TEST_MODE_1000BASET_4:
		return genphy_set_1000baset();

	case PHY_STD_TEST_MODE_8021BWQCQ_1:
		return genphy_set_100baset1();

}

Or did you want to see a different way of mapping a given speed/feature
set to a specific test function?
-- 
Florian
