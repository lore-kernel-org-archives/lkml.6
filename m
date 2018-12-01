Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A046C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA862145D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA862145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeLANDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:03:47 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:48536 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbeLANDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:03:47 -0500
Received: from [192.168.1.13] (c-73-132-37-144.hsd1.md.comcast.net [73.132.37.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 92576335C39;
        Sat,  1 Dec 2018 01:52:27 +0000 (UTC)
Subject: Re: [PATCH RFC 01/15] MIPS: replace **** with a hug
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-2-jarkko.sakkinen@linux.intel.com>
From:   Joshua Kinard <kumba@gentoo.org>
Openpgp: preference=signencrypt
Message-ID: <7468f626-13c0-a53f-bf02-675c7218dd06@gentoo.org>
Date:   Fri, 30 Nov 2018 20:52:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181130192737.15053-2-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/2018 2:27 PM, Jarkko Sakkinen wrote:
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
>  	 * generic PCI code a chance to look at it for real ...
>  	 */
>  	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
> @@ -76,7 +76,7 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
>  oh_my_gawd:
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
> +	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
>  	 * generic PCI code a chance to look at the wrong register.
>  	 */
>  	if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
> @@ -85,7 +85,7 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
>  	}
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
> +	 * IOC3 is hugging hugged beyond belief ...  Don't try to access
>  	 * anything but 32-bit words ...
>  	 */
>  	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
> @@ -118,7 +118,7 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
> +	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
>  	 * generic PCI code a chance to look at it for real ...
>  	 */
>  	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
> @@ -139,7 +139,7 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
>  oh_my_gawd:
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
> +	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
>  	 * generic PCI code a chance to look at the wrong register.
>  	 */
>  	if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
> @@ -148,7 +148,7 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
>  	}
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
> +	 * IOC3 is hugging hugged beyond belief ...  Don't try to access
>  	 * anything but 32-bit words ...
>  	 */
>  	bridge->b_pci_cfg = (busno << 16) | (slot << 11);
> @@ -189,7 +189,7 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
> +	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
>  	 * generic PCI code a chance to look at it for real ...
>  	 */
>  	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
> @@ -213,14 +213,14 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
>  oh_my_gawd:
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
> +	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
>  	 * generic PCI code a chance to touch the wrong register.
>  	 */
>  	if ((where >= 0x14 && where < 0x40) || (where >= 0x48))
>  		return PCIBIOS_SUCCESSFUL;
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
> +	 * IOC3 is hugging hugged beyond belief ...  Don't try to access
>  	 * anything but 32-bit words ...
>  	 */
>  	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
> @@ -257,7 +257,7 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
> +	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
>  	 * generic PCI code a chance to look at it for real ...
>  	 */
>  	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
> @@ -281,14 +281,14 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
>  oh_my_gawd:
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
> +	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
>  	 * generic PCI code a chance to touch the wrong register.
>  	 */
>  	if ((where >= 0x14 && where < 0x40) || (where >= 0x48))
>  		return PCIBIOS_SUCCESSFUL;
>  
>  	/*
> -	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
> +	 * IOC3 is hugging hugged beyond belief ...  Don't try to access
>  	 * anything but 32-bit words ...
>  	 */
>  	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];

[snip]

NAK'ed to all of the proposed changes to ops-bridge.c.  The SGI IOC3 chip is an
abomination out of some dark, Lovecraftian nightmare, and the code comment is,
truthfully, being somewhat nice in its description of things.  They need to
remain as-is as a warning to future generations of how not to design
multifunction/multidevice chipsets.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
rsa6144/5C63F4E3F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
