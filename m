Return-Path: <prvs=0632d1d0fd=mike.looijmans@topicproducts.com>
X-Google-Smtp-Source: AIpwx48/Lk15GSEYOYdfW6t4Eg0aU0QAu/JSSfHg3Km+xgBBLz8fQ0SQnKO5HoUYvbJ7DwuCArdN
ARC-Seal: i=1; a=rsa-sha256; t=1522848783; cv=none;
        d=google.com; s=arc-20160816;
        b=c5LNPbbqvaA/MSxDXeMjzaOhOxt2G5A7FZGYcJ3x5c7M5VBzPh/H6PcAz9prilyqhh
         vsFWrsP3Y3bIT9NjQ5NZ61m2WSEwsUwFlHHeVyXVrrxcaqs4g5d9QrEgWXRupL2YmCBi
         5jgrJAdGTW6pCAbbSIZUtkXtFBhiHIuRAD7y7xvT6LkGyogfZjin46mCtc6tFmlb3EtG
         i56+D8IjuPBMUcJWt4wnMLARISXV15uZeAS/QmrSD+fhOVH+LkWDWh/Jf8+dMB109Rzy
         itVIilyQOo+bZfijw3/hj4EJojwM6BcGvjjGndxJ1utp/VwLCK1k68g4lEuYNAN53Rpl
         cumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=wieUwGPKb4x7fLoNPxhqtmjX81e9IrrBVW8QVeObx+M=;
        b=bCD35kFUffGaY6G5zqy4WC4/gGCDY1yk9YBDDnfzQm+6HrMiFtsjJuB6cYAIaWWq+J
         FLK/GplbArsR5ITsshRaNUeX0E7Fo5ra1v9U2jMncZh1gXJp2fV6aNp4MuYZFJMJd1FF
         KlcNVgxEA+wQWTq/FpIHrWNfvDEFa4RjQR8V1G1rVLckYTydjjDHqk6DAVYmVBy9irE5
         Cv0zJtzt5+E5kDdHNwSW39TgcfM6HQR/CcToFbHZjyFeGWSkqXNIk4lW4apQWi00fiSu
         6CxwFcbvytqrTewHSxA1sdtRqX4BVG6PWTCs9P0RIr8NKpNuTp+mbjjwwWSP8pLA/kHG
         so6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prvs=0632d1d0fd=mike.looijmans@topicproducts.com designates 209.126.121.73 as permitted sender) smtp.mailfrom=prvs=0632d1d0fd=mike.looijmans@topicproducts.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prvs=0632d1d0fd=mike.looijmans@topicproducts.com designates 209.126.121.73 as permitted sender) smtp.mailfrom=prvs=0632d1d0fd=mike.looijmans@topicproducts.com
Subject: Re: [PATCH] [net] nvmem: disallow modular CONFIG_NVMEM
To: Arnd Bergmann <arnd@arndb.de>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>
CC: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, <linux-kernel@vger.kernel.org>
References: <20180404103900.4090118-1-arnd@arndb.de>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <23fe2eeb-127e-7917-0d56-714414cc8c06@topic.nl>
Date: Wed, 4 Apr 2018 15:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404103900.4090118-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: nl
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.80.121]
X-EXCLAIMER-MD-CONFIG: 9833cda7-5b21-4d34-9a38-8d025ddc3664
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Originating-IP: 37.74.225.130
X-AntiSpamCloud-Domain: topic.nl
X-AntiSpamCloud-Username: 37.74.225.128/28
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=37.74.225.128/28@topic.nl
X-AntiSpamCloud-Outgoing-Class: ham
X-AntiSpamCloud-Outgoing-Evidence: SB/global_tokens (4.30825626824e-05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5i2CpMKsJH/NOmyK4YPsXmt602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO8oM0wIXyDje2SaCnmhHqonWkbkVgKpg9aU1asJspfKYJ5o1SMNtRsuLRigvt1bLN4UP
 1Ae/eGZl2OLANHAHEjGkGLV0mmViJA7JguxGmC9W6acnZvcCQD8HMR9+9y1r+S3I72l05mJ6QL7n
 ZB8r0oUn0ax4R4S9TMzaZ0FwYTY1tWZTWzNNmwhylb58FeB2h9YZlitsIqkaMnVQUORSVxU2UOjr
 QY19nYX/K9cXl+nRZLgz3KRHukHdxSB6Rcg77E+r68Y7dXH5LDBaxyGaR2+QFGWXj6ATzFdH9bTL
 OkVQJkHwcwZdqFJg2NUWc1YcXoGeAVdJey60qD5wsNPQWT5Fs7DxsCZVCSc4CWMfN1ciq/rDvwwx
 /Mnq4zUPHanBPczntbh+2HeIlwbpchD0ehyCXytMVUE1RrI1iKhR/+NoqKFudkuEZVXZl5MTwWUP
 IhagDTGKpvPlNaHDJYiM8ilkxvf/L+5uP70weFFXER8Jf36iQtpXVxx3JGkwrtaaU5p9kKFkee4q
 j9sca6YEuZWVEgwl6glRkvmo3GX5FL4NyL8gVvwf0/ZTB5Aex3mnBkZkh9CHWiXE/VK3pyG8/wb0
 zDx8PU6PoTr3yA05BqpEWs0nj+T46VBsI2ojvJSuYS4bZVTKT2h9O2P0hgAGe2lvUeASWefCYj15
 CRjPEXcLpTy720tq+RXttiT55quaruWBOXp8nHKe0R+FkIqN7hm18QLcRhSN5p02aABNQ4f8VgW9
 /bktU41htiJ8fk7NkNOzTEFptdUTKRDYlFu1sAx5JWeGLEKf1HkSPVR4EeEdu1/i5rLPFzxGHTHD
 eQ9d+eiHMKHu1Rn5cHXI6WgdFu+UF4usDb2kk1uBwSs/6Z+6Q9R1ObC0i3fRWwwYsos4WRLRwQUd
 Iu5hLA3QYBLOcm8G4GwmZslJhQYHe/sR3M073muvvqrCtVR0JEqGtMZy60XaG0Fg3bGWhMbrnydg
 265iXj652TcauAXI0OZ/c5Dgb8+VkZ+XyFUaFRCgFITshgMJblr5U9vsEZzLans1Zt5y2DNwOgV3
 73pfDhBQ21Od5Jq44QC4G2DmMXkKN3WV4AoT2AMURe0h/KXHuYweT6JPGbNtUXmd7L5en/AU60D6
 YnxQyhLqqPsu0jOSyppapEn9a1rfFCnSMsc+vEwrNsvZ8WzbO17r4RnFykfwt4jSk+V/2rs21F4A
 hA8l0p2ll99Qn7QSIthIDjpoF+I7cHZZJpr2bkWSTaYQ1JO05db7
X-Report-Abuse-To: spam@quarantine2.antispamcloud.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596811748893246991?=
X-GMAIL-MSGID: =?utf-8?q?1596822685852214362?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

=EF=BB=BFFor making things build again:

Acked-by: Mike Looijmans

I'd be interested in use-cases for having nvmem as a module, I cannot think=
 of=20
any.


I am working on splitting of_get_nvmem_mac_address(), by moving most of its
burden to the nvmem interface. Intend to create this "just give me my bytes=
"=20
function in nvmem:

int of_nvmem_cell_read(struct device_node *np, const char *name,
                        void *buf, size_t bytes);

With that in place, of_get_nvmem_mac_address becomes a one-liner:

return of_nvmem_cell_read(np, "mac-address", addr, ETH_ALEN);

That would allow of_get_nvmem_mac_address to be inlined, and this would mov=
e=20
the link issues into modules that actually use that function.

Which may still be very confusing, since it means that CONFIG_MACB=3Dy with=
=20
CONFIG_NVMEM=3Dm will fail, but setting both to "y" or both to "m" will wor=
k. So=20
that would introduce more build failures again, right?

--
Mike.


On 04-04-18 12:38, Arnd Bergmann wrote:
> The new of_get_nvmem_mac_address() helper function causes a link error
> with CONFIG_NVMEM=3Dm:
>=20
> drivers/of/of_net.o: In function `of_get_nvmem_mac_address':
> of_net.c:(.text+0x168): undefined reference to `of_nvmem_cell_get'
> of_net.c:(.text+0x19c): undefined reference to `nvmem_cell_read'
> of_net.c:(.text+0x1a8): undefined reference to `nvmem_cell_put'
>=20
> I could not come up with a good solution for this, as the code is always
> built-in. Using an #if IS_REACHABLE() check around it would solve the
> link time issue but then stop it from working in that configuration.
> Making of_nvmem_cell_get() an inline function could also solve that, but
> seems a bit ugly since it's somewhat larger than most inline functions,
> and it would just bring that problem into the callers.  Splitting the
> function into a separate file might be an alternative.
>=20
> This uses the big hammer by making CONFIG_NVMEM itself a 'bool' symbol,
> which avoids the problem entirely but makes the vmlinux larger for anyone
> that might use NVMEM support but doesn't need it built-in otherwise.
>=20
> Fixes: 9217e566bdee ("of_net: Implement of_get_nvmem_mac_address helper")
> Cc: Mike Looijmans <mike.looijmans@topic.nl>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The problem arrived through the networking tree, but it's now in
> mainline, so the fix could go through either tree
> ---
>   drivers/nvmem/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 5f9bc787d634..1090924efdb1 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -1,5 +1,5 @@
>   menuconfig NVMEM
> -	tristate "NVMEM Support"
> +	bool "NVMEM Support"
>   	help
>   	  Support for NVMEM(Non Volatile Memory) devices like EEPROM, EFUSES..=
.
>  =20
>=20



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
