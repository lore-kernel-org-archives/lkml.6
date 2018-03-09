Return-Path: <kernel-hardening-return-12313-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsUgn7hcq8ykv4h6e1l8SS2uHMbYNobmKaalD4jINWwgvZY844oh0KbHjSggUTM0LC0Hcly
ARC-Seal: i=1; a=rsa-sha256; t=1520596004; cv=none;
        d=google.com; s=arc-20160816;
        b=jcNRdR1/CKHAM1fg8C25M8JYND3W/XbeKB79Uuz2MY2ejYkHfh85GA1kxJCyElEY0b
         n60R7AWqs1FBtIyIfsoC/7O5g/Vuwn87WtYQvIA1Nm6yMLWrOV1BYms5zS1zIFogMrTK
         UdKER0dVGH/U56qRzXXD/Nzw9rlBVuk7Tr9by1wejqLp7guVmDPFN5AqbDAc0YSHt8yv
         b8yCYnYQM9JE5DXp5xmrqzZ0/A/J318d/wbqGi7QlAjoTBbPcaZfsjjSiUjIK+BE1gh4
         xDkfc7EiESWYrwmra3ziGv+X4JywcgflcPlQxyJbVN0EQxpGd2/MgbLOn0T7LacMIsXi
         lb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=2A7qt/DPH1QecoctNmPYOdWXB7C5WzTb5lh7GMJxvgw=;
        b=KwWl4pjQs7xk6A88YTZ2x4U2+dJkL/dnYpIkjk5olSVmIxEMzMacfIMwPAFSl67sLg
         R8iMGDzLwa65fNvUJo5bPPOY2ueph9wrEtGByGBtQLRfItzb5hcNysZbw2m2GUlg93Ep
         BSSCiK01x3EV9y+Kk8yL39Y55Bbf0qE2M5q5kIZh78c79Gchft2K5misR9qGOu+r3vQN
         E/qKBUJJDJQv69P5ieGUqgWsK7Q1DUVrDrSvQyuGPXYQIxIVoMVihgDUWzIG3cwvPtzZ
         asxaqc+mjH6RbbkPGdeb4zASxkhyyoV3acdb0JZSslcYG1VLnsDA7vPZXx/28JR1OGRE
         zG2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12313-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12313-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12313-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12313-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRWlGSWpSXmKPExsUSt3Opse6ywkV
  RBks/qlisXLKfzWLrHlWLM925Fks//WazuLxrDpvF594jjBand5c4sHvMbrjI4rHuoKrHplWd
  bB4rOx+zeXzeJBfAGsWamZeUX5HAmrHlhlXBdO6KO1/vMDUwzuPsYuTiEBJYwijR2D6frYuRk
  4NNwEJi8okHbCAJEYEeRoneWZNYQRxmgblMEpNXfmAGqRIWsJd4PXcJE4gtIuAgMenqBqAODi
  DbSKL5cAhImEVAReJv22R2EJtXIEBi1ty9YLaQgIHEhvd3wFo5BQwlbnxcwwhiMwrISnxpXA0
  2nllAXOLWk/lgNRICAhJL9pxnhrBFJV4+/scKYctLbP/2mx3CBjrn3jsWkBMkBPQl+hqLIcKG
  EqumHWCBsM0leuftYYIYryOxYPcnNghbW2LZwtfMEGcKSpyc+YRlAqP4LCRXzELSMgtJyywkL
  QsYWVYxahSnFpWlFukaGuolFWWmZ5TkJmbm6BoamOnlphYXJ6an5iQmFesl5+duYgTGLQMQ7G
  D8tCzgEKMkB5OSKK9v1oIoIb6k/JTKjMTijPii0pzU4kOMMhwcShK8jwsWRQkJFqWmp1akZeY
  AEwhMWoKDR0mE9yBImre4IDG3ODMdInWKUZfjxovXbcxCLHn5ealS4rxrQYoEQIoySvPgRsCS
  2SVGWSlhXkago4R4ClKLcjNLUOVfMYpzMCoJ8x4CmcKTmVcCt+kV0BFMQEfsvbwA5IiSRISUV
  AMj3z/9rBCOv2s7t/98/WlKfsbjxfmBC5UPOD1qMFh0kvfgy94lTHr811/fmLXX8mNwx9LXO1
  /r66hsZZkecORnIP+/RjW9mAl952x1P+3Yee/7ge96tpv1I+cxJhutmmS9/lHnrzhbmbzcOwb
  rd5ye/fPlOk5t/ofdLaVvbT2vtt9Yxsrzbn/1KSWW4oxEQy3mouJEAIXQIkZhAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-193.messagelabs.com!1520595366!105335511!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Support Opensource
	<Support.Opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<garsilva@embeddedor.com>
Subject: RE: [PATCH] power: supply: da9150-fg: remove VLA usage
Thread-Topic: [PATCH] power: supply: da9150-fg: remove VLA usage
Thread-Index: AQHTt2M/t02IoHLAw02XUE+A2hGBHaPHxVPw
Date: Fri, 9 Mar 2018 11:36:04 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1D771E@SW-EX-MBX01.diasemi.com>
References: <20180309045813.GA11964@embeddedgus>
In-Reply-To: <20180309045813.GA11964@embeddedgus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 09/03/2018 09:48:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594434794789187138?=
X-GMAIL-MSGID: =?utf-8?q?1594460475576377455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09 March 2018 04:58, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wvla, remove VLA usage and replace it
> with fixed-length arrays.
>=20
> It seems that the length of array 'buf' will not exceed
> DA9150_QIF_SHORT_SIZE bytes (2 bytes). But a fixed length
> of DA9150_QIF_BYTE_SIZE bytes (8 bytes) was chosen in case
> this change in the future.
>=20
> Fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/power/supply/da9150-fg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da91=
50-fg.c
> index 8b8ce97..96893be 100644
> --- a/drivers/power/supply/da9150-fg.c
> +++ b/drivers/power/supply/da9150-fg.c
> @@ -92,7 +92,7 @@ struct da9150_fg {
>  static u32 da9150_fg_read_attr(struct da9150_fg *fg, u8 code, u8 size)
>=20
>  {
> -	u8 buf[size];
> +	u8 buf[DA9150_QIF_BYTE_SIZE];

You can use DA9150_QIF_LONG_SIZE as that's the biggest size of an attribute
which can be accessed. This will also save a little space.

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
> +	u8 buf[DA9150_QIF_BYTE_SIZE];
>  	u8 write_addr;
>  	int i;
>=20
> --
> 2.7.4
