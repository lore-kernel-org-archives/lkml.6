Return-Path: <merlijn@wizzup.org>
X-Google-Smtp-Source: AG47ELvyPh1LUCasFemzqhJ9PgI0R9VoCgfbZxvbEkH6Wn20iTCMnLbzqa6kanF7Jf/cl9YkbWiH
ARC-Seal: i=1; a=rsa-sha256; t=1520279095; cv=none;
        d=google.com; s=arc-20160816;
        b=q9HR0KPdSS8JugykZTI2CwrjxLqsSr1iUaGwP2FJlwwZqrEeQ9QNG7aRS75FSXNwpN
         0sOlOf4LNBMznRE9HSWFr5tdMEQe8PWPGsrRc325YP1RigWtgRcHSkRcIpCg9adbqmmj
         LkttwiXNqBZPz8DJQMyiaZ2P+J9vkwmkG32s6iiShapG73EHfb3v9wX9zzVWRnKXsyoB
         eVsgK1tYiZKiNaHlA3Wym1m7boUnZsAjv4rJE/RMHjN+PPY02sno9tbTpl19wENObxuw
         bDZkLpGdsuV7goAbCkgsksdx44rrrfWKs2vRN+8RJyt2TSDX84wOOIIQ2xXRtF9o9R/D
         TWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :to:subject:arc-authentication-results;
        bh=zIGZOK6jqn8O8eY3g01iIha+akuromdJzEsofYIaP1M=;
        b=hw+iWYGIP19e/Ke0jbyP3dhjZqmXaj7qeumDaJmg/Sysm+P4VWOehI3l3ATGM7+kFG
         P65vRHscPTX8ZRIeT3zPY5MJJBZeEJ49PdY/zktf33TWLFIyg5CbHSruIRDfzsBkb8hH
         xt96nTw8NEmNBxkLisBIePznvVql7qz0hRx+Tuhxmyw0YKcTV8+fhe5m0o1/REx9+o7r
         SqnJwMi9mE7aCPs0Gf0sWRuHIAOZI9PFXsZTZQmiyUq1SyePXDDvAV34FJwjfbZidB15
         tbxhJFpyWIqRuuCDLiX3gUyhUIDY5FHODu7hcUKO2YkcrlvbqozoDR+Kp5LQYbmJPzHs
         z4Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 188.165.243.101 is neither permitted nor denied by best guess record for domain of merlijn@wizzup.org) smtp.mailfrom=merlijn@wizzup.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 188.165.243.101 is neither permitted nor denied by best guess record for domain of merlijn@wizzup.org) smtp.mailfrom=merlijn@wizzup.org
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
To: Bin Liu <b-liu@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?=
 <pali.rohar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
 <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
 <20180302165439.62xw4slhhupy4vy5@pali> <20180305192844.GE14921@uda0271908>
From: Merlijn Wajer <merlijn@wizzup.org>
Message-ID: <54fc4244-2584-f63d-23be-9e0413bcbee4@wizzup.org>
Date: Mon, 5 Mar 2018 20:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305192844.GE14921@uda0271908>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wAfqtYmuGfZKab562liZHgjPqAQ3Nlwv6"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593781038730915565?=
X-GMAIL-MSGID: =?utf-8?q?1594128173028118181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wAfqtYmuGfZKab562liZHgjPqAQ3Nlwv6
Content-Type: multipart/mixed; boundary="I07G5oaIMgXlrTNCraeDtLKVWEUdTltgJ";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?=
 <pali.rohar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
Message-ID: <54fc4244-2584-f63d-23be-9e0413bcbee4@wizzup.org>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
 <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
 <20180302165439.62xw4slhhupy4vy5@pali> <20180305192844.GE14921@uda0271908>
In-Reply-To: <20180305192844.GE14921@uda0271908>

--I07G5oaIMgXlrTNCraeDtLKVWEUdTltgJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Bin,

On 05/03/18 20:28, Bin Liu wrote:

> The musb udc driver sets the state to b_idle without checking a
> gadget driver, this should be cleaned up. I have add this in my backlog=
=2E
> But if this issue doesn't bother you much right now, I will make the
> action low priority and address it later whenever I got time. (likely
> not very soon, I have a hand full of musb driver bugs to fix...)

I can try to fix it this (or next) week. Do you have a pointer for me?

Cheers,
Merlijn


--I07G5oaIMgXlrTNCraeDtLKVWEUdTltgJ--

--wAfqtYmuGfZKab562liZHgjPqAQ3Nlwv6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWp2eKwAKCRAGN09rynK8
WsvQAP4vTZ+XjddsvVS8aVClUIvyWd+RtQ7YuHbinXbA2GH8MAD/V696K0MOoU8s
Wk9Y6Hpkohle5juuYrAstJJflJlmuQU=
=dUtV
-----END PGP SIGNATURE-----

--wAfqtYmuGfZKab562liZHgjPqAQ3Nlwv6--
