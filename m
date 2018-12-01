Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019F8C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D9B20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D9B20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeLAQK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 11:10:59 -0500
Received: from mout.gmx.net ([212.227.15.18]:46629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbeLAQK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 11:10:58 -0500
Received: from homer.simpson.net ([185.191.216.123]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfkUs-1hHAZL2Lta-00pP6t; Sat, 01
 Dec 2018 05:58:45 +0100
Message-ID: <1543640322.5017.61.camel@gmx.de>
Subject: Re: [PATCH RFC 01/15] MIPS: replace **** with a hug
From:   Mike Galbraith <efault@gmx.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Joshua Kinard <kumba@gentoo.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>
Date:   Sat, 01 Dec 2018 05:58:42 +0100
In-Reply-To: <20181130192737.15053-2-jarkko.sakkinen@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
         <20181130192737.15053-2-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:w9wslFRx1u3RVruy7C2rQ3n1g24tyVv9mX0xZGVPjq4LgnUipmF
 Ho22X071mK8vzaeDDuHCOg3zZ2VwD26PkvIhC0ZMOYWKEb0kRp+NzmaF6nwpstnwb0+HUPO
 cQKk313jxCEHmru35vK8fI0WI5DjCyWRjIaG/3AeE9Bb7EvawYzN6NmUlGbtH4w2vrORYN9
 h2EHawLTqYYWFElbxecjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XT6wiWwS2bA=:ljOfhWL/mPA1J750K25YJL
 1eI3r9d617ZZFbeIP4ljrkhqMg7UK4U1qEg/3iMCuVUMO5XlKs/oNbUekciC1j66yj5GocVyx
 loXCv05m0uoeQQmRlSR3XqnhbMSysCuTc/lNj8ru/h7iZ00+6x8BFVzvujpQ8IDqfRhHZvC6p
 mD/i7McuT2duCBr9HOv/MKO96gQaazoFLX/PijXUtP7QL1Fxk+IugR29ptRUfQvuw/M/HmbYZ
 Kxv2kqRMZz7x0x5C4zjbQbr3bMDwQsp7jJM5D+ld0/ncKMxQi3RTY8Of+CJjvwlIXp7rWFSuu
 uvEWikuza3dqskRi8QCNJmU7RuPnsPRNX6/G3aOAXgNLvrgJOZAtBZ/FnqK9fUVIu1nI0mcDT
 ZfyddQo7+pBPvLBkk4nF3kk3nzptnku8G5P/xeZ/ow79VUQ7MHHHY4qowDv96J8iTlZRCUhIU
 9/QnPYNghDc/zIsnSwgdGTdh25FW4uGv6ZGUUnasLIbASCKAVzZV1E3W/aIAtZq7Sm2hLH8Wu
 3NYgofJjSovwR4IhCrXlJpuIxapf/JdxDvUwMx68my/BcFOP+0bVpcHdPMAQIh+yuJRL6Wqot
 cybeCB5IX2uf/bCCXc63oQ/WC34VBuw/eo/KRqSSYBPPJJxF1VyXSoN/rIBcl/kduRRY4Op0N
 mpZAD1HBToz23uH1Ri4xPCcH0vt8I6sPI7P/oQYAfxa/y8i6KvpSTHJsRjPfuSR3DrIcIVMUn
 4/ZPaPjP7ZfVBHHNr9vEQHgbPMXGZds5JcClgEZYrAJrDEraWa2ugsC7pMPSeSUz3sB5ilE06
 44zze6U7S7Q3eIqJJKnoYfBq400sA3+hWNgXwCobKe2kGscIJcjiB9CEWtC4O6JxN943ovBKv
 09D8YC49uGOcSp57gQ6IUMM8syoanR0h34MBTf4uoxJj/FGnSvlK+OabhiAq+R
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 11:27 -0800, Jarkko Sakkinen wrote:
> In order to comply with the CoC, replace **** with a hug.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/mips/pci/ops-bridge.c      | 24 ++++++++++++------------
>  arch/mips/sgi-ip22/ip22-setup.c |  2 +-
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/mips/pci/ops-bridge.c b/arch/mips/pci/ops-bridge.c
> index a1d2c4ae0d1b..c755c4c92fa9 100644
> --- a/arch/mips/pci/ops-bridge.c
> +++ b/arch/mips/pci/ops-bridge.c
> @@ -56,7 +56,7 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
> +	 * IOC3 is hugging hugged beyond belief ...  Don't even give the

This obfuscation is a complete waste of reader brain cycles, as it will
transparently be reverted to the original in order to restore meaning.

	-Mike 
