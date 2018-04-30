Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AB8JxZpZNOHAL5ObQkImFoJ5L/4o/dUs2q4hVh69HTJQYsOxnhqoc7paos51RCjY9glizEF4Kot1
ARC-Seal: i=1; a=rsa-sha256; t=1525099478; cv=none;
        d=google.com; s=arc-20160816;
        b=sQJ1MV/51xhxawcXQjyV2D3QqX6c2zXoobgWhGnETrEbcWxWEpDjT7AMX+wojeGNxe
         Wa8szS4Zstt4qjIMX02u8abMVWwqtG6oshND/K7SA2vV0vYaVftZ4JSOfxK5zIEXMyOs
         QjbLaubA4PzayAX/2Zmb1oyDpD0fHarVi5JoNSs7sfLAdTzw6reOVYcPq9NbyWQ+PvLm
         Uca0huBV5al4ujMx6oe3bb15p4KQhIKexo98ugG9VFzrUDXS5s0pG+TsWr2/sv8sU2ZN
         Jyy5nYdNrEXyHSuuEWkm71QCNTcjBOcWlokdDU2ije3TWO+JAdmIhBCpfTyCOUjL88Qd
         00jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=lKB7ntDt9zOSevAeHFNN9o6WGAOYgakXix7TLKOtYRs=;
        b=kXjULjQxAPxxBXnQjNlTgpjGPHjChaWdkJUvrjte3ciJk8KOpYQA9gkUiH5hV6Ub0C
         VRqg7TXNCgalasBcvJuDlQZ0IzKvNYuP6CAilF/7UhIsyPyy3GgA9KrSj+DHLCbFdfTS
         cnokShTVP3S8k9xZBdcgdZ/VHGv89/C/VcYGDq4ljAbgYwrqy91Krt6Hqds6tlquKR51
         j+mflhtgWRDX7jU1gs7Im21FKmoSqw9ueLSTWYhPr85sHicBz6OszmfjsWvPYqh6DTh/
         UEfepeGpJ+crU+KytUG1DWyqQcnuRtWdwN21Ww531wPCPVRR0WZzWtdjCdSXHpendub1
         t/hA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.116 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.116 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRWlGSWpSXmKPExsUSt3Opse4V7ed
  RBquPGVo0L17PZrF1j6pF1+qdLBZbb0lbXN41h81i0bJWZgc2j3UHVT3mnQz02D93DbvH501y
  ASxRrJl5SfkVCawZu+efYS+YwVnxc/cG5gbGt+xdjFwcQgJLGSUu35vC2MXIycEmYCEx+cQDN
  pCEiMBZRonld7aCVTELHGSUaLq+iLmLkYNDWMBO4vi3ZJAGEQF7iZULnzJD2EYS51avYgWxWQ
  RUJaa+f8AOYvMKBEjM2LKFDcQWEjCWeLWuE6yeU8BE4kvfe7A4o4CsxJfG1WBxZgFxiVtP5jO
  B2BICAhJL9pxnhrBFJV4+/scKYctLbP/2mx3Ctpd4fe8dC8hpEgL6En2NxRBhQ4lV0w6wQNjm
  Ek+OPmCEGK8jsWD3JzYIW1ti2cLXzBBnCkqcnPmEZQKj+CwkV8xC0jILScssJC0LGFlWMVomF
  WWmZ5TkJmbm6BoaGOgaGhrrmuoaWprrJVbpJumlluomp+aVFCUCZfUSy4v1iitzk3NS9PJSSz
  YxAuOYAQh2MG76kniIUZKDSUmUl2XxsyghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErzJWs+jhAS
  LUtNTK9Iyc4AJBSYtwcGjJMLrBJLmLS5IzC3OTIdInWJUlBLnXQ+SEABJZJTmwbXBktglRlkp
  YV5GoEOEeApSi3IzS1DlXzGKczAqCfN2gEzhycwrgZv+CmgxE9BiacYnIItLEhFSUg2M3jNab
  +h2uK3My93e+uD10snnmdf8E03unzNPbxG/33KfdZVRVvM5yxdxsbDdO/DM+KCJdYNQDpdCwI
  659/TX7/+5fPralXs5Tx3nLP/Or8wg7fJ39s39tcFTXHtKtWX4d16VS53O8sBsUp+Zel/wn5w
  T22Kj9qcqffp7S9T3Sc7lJS5VMj+0lFiKMxINtZiLihMBd+Ikc10DAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-23.tower-246.messagelabs.com!1525099472!94958!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] typec: tcpm: Fix incorrect 'and' operator
Thread-Topic: [PATCH] typec: tcpm: Fix incorrect 'and' operator
Thread-Index: AQHT4IZklJy2GxFg+021WSxzCxufzKQZXteQ
Date: Mon, 30 Apr 2018 14:44:31 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E9323@SW-EX-MBX01.diasemi.com>
References: <20180430132305.GA20092@embeddedor.com>
In-Reply-To: <20180430132305.GA20092@embeddedor.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 30/04/2018 13:00:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599177583315006788?=
X-GMAIL-MSGID: =?utf-8?q?1599182711240352329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 30 April 2018 14:23, Gustavo A. R. Silva wrote:

> Currently, logical and is being used instead of *bitwise* and.
>=20
> Fix this by using a proper bitwise and operator.
>=20
> Addresses-Coverity-ID: 1468455 ("Logical vs. bitwise operator")
> Fixes: 64f7c494a3c0 ("typec: tcpm: Add support for sink PPS related
> messages")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Good spot. :(

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

>  drivers/usb/typec/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 1ee259b..7ee417a 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -1772,7 +1772,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_por=
t
> *port,
>  	enum pd_ext_msg_type type =3D pd_header_type_le(msg->header);
>  	unsigned int data_size =3D pd_ext_header_data_size_le(msg-
> >ext_msg.header);
>=20
> -	if (!(msg->ext_msg.header && PD_EXT_HDR_CHUNKED)) {
> +	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
>  		tcpm_log(port, "Unchunked extended messages unsupported");
>  		return;
>  	}
> --
> 2.7.4
