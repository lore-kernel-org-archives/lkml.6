Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AH8x225usF81gIrKMVbegIaRN7QX6smeAfiD8dz7rWdkdlG/FUQWfByhhGn6ju+NIDJuIm4N18qv
ARC-Seal: i=1; a=rsa-sha256; t=1519229697; cv=none;
        d=google.com; s=arc-20160816;
        b=cF4MnKsVZ5h17wQsOLLGRBpjeru9qa8yJyg9CPdlBu6ohER/BheIljoFTtDfGKyTZW
         z78zZ/D4fZULUlqbXlGP3vyJ/N+w68tgMqKJuOjMj2Oa/Gd2S7c39EkzbgpF+27eMw0W
         12ydwGf/xu3eEya90pR6umKbcRWy4MtDMdKYv/jbavupl1VFAPzyyIXEv9iA+tuLezsg
         ci7eEAbuGNzlrE9A7ItwCeU+g1QTsWeoo953YO9Rp1h/6pEuXlto4CuOCY0wVo59s+ve
         oNwnp8RxuaRrpNcvdpdoT/tHmL+n61zysh2gEQ/lbio0QegJQbjyz2y20zLO7Hp0RAvw
         A/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=KckHH2LvAII2I37pKHdXzvDeuJBho73htyn7XFBZmyU=;
        b=og3BO418+u/fYu2bYq6aCn7kCyOjBLgnryklgohd6ZDZ7uqo/uHPa07QfdPahbRb67
         JaTzcoypqcf68Z/Kfj2McnYaBvcqypvddBsXtxqoQc7SgONq5BS8WIpGgkdCmeXgEAdU
         CCVXYRzfLWecwTthTAqWW9+3pQOjjtK0SYb0so6fZlmzMXCVRJlYbT8YkAgeMvfdsUWG
         EQT3V3v5oXisDBDgJYzDmRkgV+JAUvx0KZLBvqiLhLaJwuEdO3cJM4Of4q84UjjMlG8y
         xlFomH7VQs8i9ibwunXlcm33LrT8yS47Bn1GO5EEEp98i8R4Zv07GKrvqBMkoHDzSgPd
         k7/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.21 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.21 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Date: Wed, 21 Feb 2018 17:08:15 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: kbuild test robot <lkp@intel.com>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Nathan Fontenot <nfont@linux.vnet.ibm.com>,
	Michael Bringmann <mwb@linux.vnet.ibm.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 5/6] powerpc: Implement DISCONTIGMEM and allow selection
 on PPC32
Message-ID: <20180221160815.dxhpsejt74zeqqjd@latitude>
References: <20180220161424.5421-6-j.neuschaefer@gmx.net>
 <201802210756.OZokd64C%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cqenwn745jgkwtzn"
Content-Disposition: inline
In-Reply-To: <201802210756.OZokd64C%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:XPRagCHdtM5uZhfIm2Z5NBnY7KrwWR68QCk967ByBISWPyO+F9D
 cTPfxqnOk0XEBny9pOGxGOhlyh/E7UTvTvHhRvPhO3M8LnoZQYiw4GJJwwiN1spsWotelxX
 yluqZx5vw6QLqr4Ih0pkkGbgH7JNap/Xs+32fc55JOMj50ieL2jKAiCk9QDNUZKB3kONnjb
 TkB1VYW09hbe9cYeXumFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TeLH6u8bNk8=:R3D9Ll+5tuK8U5YjAQ+Nnd
 q8eewN5K2lhjbaHbL9q3G342925+1hJ8vDbqhiED1xvNnpIVmCIC/SSpQPquzTSBUyCqahvK6
 oJTlZFbg8MaFfbTkKT9xVQZ2vL9hCYWY6Pw0Ew6tA2GJH+FdkzemSayN29pxBi+7JzhbjxK7r
 2ws/a81WeNRJwXuzoScZrrfkWbBhmgambgEbID5OxXsbaLpF0CrqdHF8cWE/UnRoTZhOPrEf3
 A0N9CtiAUlYcQzDC4tKpuSqY2oG2/xpJCzQWaZa0RKd+r3Sv+sZwZ2OB8ly0G7i7KGbUjuog4
 HQ3HnTrCBnGEwPsv4juH0tMwLFplWGBpnoIiNPWFB8Oz/Q4sj9+wzxG+lk8gKl7WR2Y2AT1mF
 4FEcQiiFCbbODWsOwk/evnLdxC/S2Lvui5uFG+E6zMHEbK+AUC/A+eQ7l5xDRTTZJOB3AjgTj
 YGYd5Hsst5wA42cwzx4LrPEQEZvohqDH7H1XHaVcNajhJOSDkEhiwyM4JPdscSsQz+ksQ+2aS
 3AuEAgPsUSuzlv+d5gJFr4QFS3iEDEfLJNxMI+bwpeauI7JQLDK50J9sORtLpVkCjYz5EkTq7
 tzg/S2GJq3TKHC2xQxSwPw5U0C8O5O5+koN6sVEOQwqbiCQ47/QUUHKnWpCcrBGlKlb9qOyUm
 Tsb1sATLaUbpCivgjDO0TXOMag8CSoLbP2IyI0Y1lTURbhb5fTiVuOozrC+atDWDjziWuT0IY
 WhNiEEYQR21oTZapVPdtCwPicwvKpwOzIUGjJjZkSQIPV7mXkugQJaOxmhwmVQJJ5d0jSnKMk
 xmXS+hPgARFBynUd+0AeRrpjlXlSw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592937314761110102?=
X-GMAIL-MSGID: =?utf-8?q?1593027799746800413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--cqenwn745jgkwtzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2018 at 07:46:28AM +0800, kbuild test robot wrote:
[...]
> >> include/linux/mmzone.h:1239:19: error: conflicting types for 'pfn_valid'
>     static inline int pfn_valid(unsigned long pfn)
>                       ^~~~~~~~~
>    In file included from include/linux/mmzone.h:912:0,
>                     from include/linux/gfp.h:6,
>                     from include/linux/mm.h:10,
>                     from include/linux/mman.h:5,
>                     from arch/powerpc/kernel/asm-offsets.c:22:
>    arch/powerpc/include/asm/mmzone.h:40:19: note: previous definition of 'pfn_valid' was here
>     static inline int pfn_valid(int pfn)
>                       ^~~~~~~~~
>    make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2

Oops, I'll fix this in the next version (and compile-test on ppc64...).

Weirdly enough, x86-32 and parisc define pfn_valid with an int
parameter, too (both of them since the Beginning Of Time, aka.
v2.6.12-rc2).

--cqenwn745jgkwtzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajZlkAAoJEAgwRJqO81/bC9EP/0FAWTZxjLN1131rfl2qXHHO
PiRFHOZgt/dlfqJQiFZSF8F33gEwQMn29NdOFqPnFyUT+9BNoBbv3RcEVNuJ2Y26
gyEVfVSINkrhqHHxtHNl+NlFsClxlo5Nrhss4gja1Jm+fZDrvFDj7YoBR1mINdbs
Wcf4OSqUjSW8ZBG1MJLli5CX5QeKpzmhiBVMKiaNEIyPaceoNZVFSIsqwTxK0LcY
ILkaUS2lAh7GF+C7vdE7/ur0U77+yPq/dc8RAw0XzzRLfAzuwt8Q12OqnoyoK598
WMcsFHF1BYs403wktKCHsLlSgQ7YfDDKq+VaJJ1kWm0FwPzAMvSkwyIUcZltAacC
c6JKm7P+CkyFkrBe/iVIGyoUSWyWAg94V4xT+UdqKz0fQxMRd0HzQNVc0q6Lwgr4
ij1ylSr+x7uuxlgPtDn1WSP5W9hGCAHcKs7g/XVMqCLXvAgElZ6edZmdSJ2wMDEJ
TRNz6LMOwUAV1ull1t+1EGOXQzKJDT/fvdeTteDjwjoc0AeycpF1x/tHreYNqaQ7
ulaG5A5tEfIZ+IxsvOjNJos1WXWG/oGwdqGcFsPgjlehtO9AEKGvlhUWcqRKItmP
LGO1oWLPejICN8Ev7eeZbJI8JFzkFcKTnZoeJjAtOIV1IOolGqfMFDKgAGVUATkM
5qCaWm6302I3zd+K6KD3
=207V
-----END PGP SIGNATURE-----

--cqenwn745jgkwtzn--
