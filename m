Return-Path: <kernel-hardening-return-12421-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtQrKTlumaqgnxEqbbiskFXjZ+3fc0+fkUChSVYDfN7lvgMoKhOh/LnW65nefyb0C/KDLXt
ARC-Seal: i=1; a=rsa-sha256; t=1520843310; cv=none;
        d=google.com; s=arc-20160816;
        b=MPz3HCLs/TgoTcyaGnPopaCmPU/I5hSo55HhYOmG3DWkNvK35GhoS4mBZBcv6UvHoM
         y5IKcCcOq/CyqIIn7Z2dJFj9NCognPbpNHC5ZOOqhslcV/jokSgwXqMGNyQviZAnVGqj
         infThKv5tBqGguwj90WfzDgfiIqshsoId1PlZWakoinKBVX6RCqV/roR/zXSQgvRHSRZ
         IoSFudl8djlE0LwWM7Fn+svzZ793b+PHJBZins0rh8pVqnZUgoRTQqz5nMoI1zqJFYrM
         1cR28mQB8MlF9j1Ii54M8b+BuDo9FvjGDdZulu6n+6ILmuxv4d2avOWMZYEw/sfAGA4w
         Lt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Y3lrmva6RbSF+epu951RU5Zfixy8c53ZzNCor2cE1p8=;
        b=fsuUfWCAg7k0gQt+blcsMg2vx0QYLFz0B028Vg0dhF7mSBvSEIcsbZnzS2XBLLQ7/z
         lkHjC5m8dkBBHUdPtvx9LkYFbxhJaXYrfuwPzVWFSsqaH6SJiE6rOvRZboZfN+tukPzb
         mmD3nTOFHkhrLyElDcCcYQqK7X1OxFgJY+dHt5TtVCuDdH3dTUhiq9l6e7ltYCGfxz7Q
         NDnBJZF6BaGZ4rgtAo9W7QucKPlz40fAtFf+2tRrDDHQWGO/Ao6a3S7eujAG+xsAsb/e
         sDmtEhnZ+DGqnpo69K0o+MZ8DWKym2PFSZ+LBdHmusZ4UEbgy9fsh0AZJ6I70rXkL3Ls
         OnJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12421-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12421-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12421-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12421-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRWlGSWpSXmKPExsUSt3Opsa601bI
  og8Xv5S1WLtnPZrF1j6rFme5ci6WffrNZXN41h83ic+8RRovTu0sc2D1mN1xk8Vh3UNVj06pO
  No+VnY/ZPD5vkgtgjWLNzEvKr0hgzZj3YC9LwSSeivfrXjI3MPZydTFycQgJLGWUmLFsNnsXI
  ycHm4CFxOQTD9hAEiICBxklHuz6wQriMAvMZZKYvPIDM0iVsICTxIk7L1lAbBEBZ4k1c3YCdX
  AA2UYSP7/xg4RZBFQl1nW8YwSxeQUCJLZv3M4GYgsJGEh8mzARLM4pYCjx6OR/sMWMArISXxp
  Xg41nFhCXuPVkPhOILSEgILFkz3lmCFtU4uXjf6wQtrzE9m+/2SFse4nX996xQNj6Eo8eP2KE
  sA0lVk07ABU3lzh94BwrxHwdiQW7P7FB2NoSyxa+Zoa4U1Di5MwnLBMYxWchOWMWkpZZSFpmI
  WlZwMiyitEiqSgzPaMkNzEzR9fQwEDX0NBY11jX1FwvsUo3US+1VDc5Na+kKBEoqZdYXqxXXJ
  mbnJOil5dasokRGNsMQLCD8eDZxEOMkhxMSqK8ydzLooT4kvJTKjMSizPii0pzUosPMcpwcCh
  J8OpYAuUEi1LTUyvSMnOASQYmLcHBoyTC228BlOYtLkjMLc5Mh0idYtTluPHidRuzEEtefl6q
  lDivPcgMAZCijNI8uBGwhHeJUVZKmJcR6CghnoLUotzMElT5V4ziHIxKwryzQabwZOaVwG16B
  XQEE9ARV04sATmiJBEhJdXAuPzP39DYqQarcmq1Kw8kzTwxd9H3l6utlousbjirs6CBteeDyL
  Lza2vPicnscHxhem8qZ2/D1j6OtCmO4dvz1jLvX7BT/dC+Wg+egnhZia1p9deKDLPX9zCcv6t
  woPrwavvzyVsSb90rM3mSNa3xCRPHZLWSX1P93nVPf/g+oO/XyVf7ryQuZ1JiKc5INNRiLipO
  BADsBbXycwMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-44.tower-223.messagelabs.com!1520843290!82274!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>, Support Opensource
	<Support.Opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<garsilva@embeddedor.com>
Subject: RE: [PATCH v2] power: supply: da9150-fg: remove VLA usage
Thread-Topic: [PATCH v2] power: supply: da9150-fg: remove VLA usage
Thread-Index: AQHTt9Q+yrwqJIkF00KeydL/56DuIqPMR/PQ
Date: Mon, 12 Mar 2018 08:28:09 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1D92EF@SW-EX-MBX01.diasemi.com>
References: <20180309182708.GA18542@embeddedgus>
In-Reply-To: <20180309182708.GA18542@embeddedgus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 12/03/2018 06:05:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594485697714454043?=
X-GMAIL-MSGID: =?utf-8?q?1594719795037925057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09 March 2018 18:27, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wvla, remove VLA usage and replace it
> with fixed-length arrays.
>=20
> DA9150_QIF_LONG_SIZE (4 bytes) is the biggest size of an attribute which =
can
> be accessed [1].
>=20
> Fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
>=20
> [1] https://marc.info/?l=3Dkernel-hardening&m=3D152059600524753&w=3D2
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
> Changes in v2:
>  - Use DA9150_QIF_LONG_SIZE instead of DA9150_QIF_BYTE_SIZE as the
>    maximum size for array 'buf'. Thanks to Adam Thomson for the
>    feedback on this.
>  - Update changelog based on Adam's comments.
>=20
>  drivers/power/supply/da9150-fg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da91=
50-fg.c
> index 8b8ce97..7ea2188 100644
> --- a/drivers/power/supply/da9150-fg.c
> +++ b/drivers/power/supply/da9150-fg.c
> @@ -92,7 +92,7 @@ struct da9150_fg {
>  static u32 da9150_fg_read_attr(struct da9150_fg *fg, u8 code, u8 size)
>=20
>  {
> -	u8 buf[size];
> +	u8 buf[DA9150_QIF_LONG_SIZE];
>  	u8 read_addr;
>  	u32 res =3D 0;
>  	int i;
> @@ -111,7 +111,7 @@ static void da9150_fg_write_attr(struct da9150_fg *fg=
, u8
> code, u8 size,
>  				 u32 val)
>=20
>  {
> -	u8 buf[size];
> +	u8 buf[DA9150_QIF_LONG_SIZE];
>  	u8 write_addr;
>  	int i;
>=20
> --
> 2.7.4
