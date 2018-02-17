Return-Path: <ed@cashinworks.com>
X-Google-Smtp-Source: AH8x225CLaMCZdhS94YKUV+D5Ex8h5zLxmvcLk1XxNOQiYN4jmSJFegxJdTfz3M0P4uiYY/OB62y
ARC-Seal: i=1; a=rsa-sha256; t=1518898926; cv=none;
        d=google.com; s=arc-20160816;
        b=zvFPpDt1twH/qYJwJPSkhlLY8ocnjse3HP8Yj90HxMwq7Tzx+gc3pRlByeowqUJXNI
         GUorlXjy9WpJ4MLmklQ1cKWvE+NSzZbhmOhlFZSvc2mtBFf95Um9gjOrlrBHipGtArpa
         QKxw2k3cxlRXjJSEUvDHaGPYUxNVTvNZ95/LZNoUFdI7FgHUrlK5vY9dxZ57tapmlnav
         Im0QmyZggzOzXoCGLfZxswQw6E2FiaDhq+30ebCC1WKw6uaKrZR8MEr5+Edzcab5mT87
         4HnfWG4rPjRZKtYNnpRSPkqYqKV8DZzxwa0tJwGcUbM28DSzliYpQ1yT/fr5iuMDKIVo
         oaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:arc-authentication-results;
        bh=GK+lH9rLrhDG6rf5Hum5YklWieh0Qg4m0oeYdRyjF1I=;
        b=R3SrmwlECNRapzPqPR3q2rzRk0QmFSzXLX8nt7yEmxewmYDlahXX4eoPlQ5hyW/T7R
         wiNVoUP/rkBVWg8EMhnHB7ZdC4Rnnra8946pDgpmONOvv7hbS7tO62SzV9r9+BmfWMwv
         2RteeGW7Ki9fSOozPLdtSri4vEikvq864YvxGn4U1u5OYK+oHaqA5LfELd21rZEfFnZ/
         A2nxnfMac4Dd7PJTXGDw8c0LJB+PD4Bs+ft2LmP8nIE0F0yC2BeIC5NvLujjkNw5l5Ig
         dgQjOdhLpryr3NmeakC7sOi7XhcuhS9OhRE4Zymwg4cXWaIjm//+AKuCivv6wUM+rYn8
         pbIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 67.222.38.20 is neither permitted nor denied by domain of ed@cashinworks.com) smtp.mailfrom=ed@cashinworks.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 67.222.38.20 is neither permitted nor denied by domain of ed@cashinworks.com) smtp.mailfrom=ed@cashinworks.com
X-Authority-Analysis: v=2.2 cv=G85sK5s5 c=1 sm=1 tr=0
 a=6lV6tj8ir7tGSl/9xQZNPA==:117 a=6lV6tj8ir7tGSl/9xQZNPA==:17
 a=IkcTkHD0fZMA:10 a=Op4juWPpsa0A:10 a=9pOfaIXFVCWWA_ahaSMA:9 a=QEXdDO2ut3YA:10
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] aoe: document sysfs interface
From: Ed Cashin <ed@cashinworks.com>
X-Mailer: iPhone Mail (15D60)
In-Reply-To: <alpine.DEB.2.20.1802171537240.2205@hadrien>
Date: Sat, 17 Feb 2018 15:21:04 -0500
Cc: Ed Cashin <ed.cashin@acm.org>, Aishwarya Pant <aishpant@gmail.com>,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Greg KH <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A411BD5-B759-4734-A818-DE5F545F913A@cashinworks.com>
References: <20180216153900.GA12832@mordor.localdomain> <9ddc04c5-eedf-b88a-0cea-bd0c91a2dfcc@acm.org> <alpine.DEB.2.20.1802171537240.2205@hadrien>
To: Julia Lawall <julia.lawall@lip6.fr>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box320.bluehost.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cashinworks.com
X-BWhitelist: no
X-Source-IP: 24.99.197.19
X-Exim-ID: 1en8yp-004H2v-1Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-24-99-197-19.hsd1.ga.comcast.net ([10.0.0.100]) [24.99.197.19]:58838
X-Source-Auth: nobody
X-Email-Count: 0
X-Source-Cap: bm9ib2R5Oztib3gzMjAuYmx1ZWhvc3QuY29t
X-Local-Domain: no
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592572558446163401?=
X-GMAIL-MSGID: =?utf-8?q?1592680960424170405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On Feb 17, 2018, at 9:37 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>=20
>=20
>=20
>> On Fri, 16 Feb 2018, Ed Cashin wrote:
>>=20
>>> On 02/16/2018 10:39 AM, Aishwarya Pant wrote:
>>> Documentation has been compiled from git commit logs and descriptions in=

>>> Documentation/aoe/aoe.txt. This should be useful for scripting and
>>> tracking changes in the ABI.
>> ...
>>> +What:        /sys/block/etherd*/netif
>> ...
>>> +Description:
>>> +        (RO) The name of the network interface on the localhost
>>> through
>>> +        which we are communicating with the remote AoE device.
>>=20
>> I'd recommend changing that to, "network interfaces".
>=20
> Should it then be "names"?

Yes, s=E2=80=99il vous plait. Merci.

=E2=80=94=20
  Ed=
