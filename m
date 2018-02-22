Return-Path: <outreachy-kernel+bncBD2YBJOB4QPBBA4EXPKAKGQEZXC3YBY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519305219; cv=pass;
        d=google.com; s=arc-20160816;
        b=cnB8qigLA8aU75ShW/LiXAoGeV1OBmOt9XjFrR4ziRhxLpNQHyx+rLdXapa+IbFPOq
         6xP4iIrZD1ZCKAXGLGQna+q08lzeTyjWDsYWGk5z07BsffnAjkAtZWpXNXxCNDyXyBa4
         vG8qa8NXe7NE54rMnj3p2f1qEbbF5VNTKSGIqwuM6G16BPlTmTEBnz5Qg5ek1y88wt2J
         HN/yuhOb9u0tFVfZgwuMzsp7Ibke3KT3bDokPe3MR9PzBahENz74CJZdpUwwiSIq1acz
         OycZeZrUQArw9rcjPe/egublSmNlqcYBRa3PMR1UJRywhmoxGyAgcDabl3uq7j+nxEeC
         vB3A==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results
         :arc-message-signature:arc-authentication-results;
        bh=DCM6FxYZyS6beAWYcpz3SG1KyCiTppRHhDOeFEWDQGA=;
        b=zU63qVK8+XdFylJ909M+9KlgIkKZ9fOX9UQ3G0UQcJk8CUiIqkF8NoY50uST2lwxjg
         ng+hoxHs51rB4zq/LJj1VCafsGtkIgIT5zFsxMpK5ah4ik1PLHg5xlkj5bn9hPA1XUuc
         gO38BNmd9ciFwIM+Zot16UImFf2KROoDvnWqT15RvOiybw0GLUhjCmCQnDtNiEBtXbb6
         3KCypuqN6RDSWSpk39mYn3jQU3TCE3qwVY8UdNzGDwHfBslVKaAbwaNGZLQr3P4X5xFV
         HC2aE5wZ2LZH81WlM4AEHYA9Rh+9G0VkYyb0sSRvFpSPl6pY2BG1oi3kSFMtMdGh3jT/
         DUPA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=r4gWJDUZ;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WnKk9EAw;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbba4expkakgqezxc3yby@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBA4EXPKAKGQEZXC3YBY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=r4gWJDUZ;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WnKk9EAw;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbba4expkakgqezxc3yby@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBA4EXPKAKGQEZXC3YBY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1519305219; cv=pass;
        d=google.com; s=arc-20160816;
        b=nQSyh0vNUHrgfSK3B6TE+nuy5MD2Fm4HHD/5SCycb++X7/NcLHNQKQok856iBE2jWs
         fZNcFuIzEIk66qSKTVJqMI6rmf8H1/mbA3bR/KuLGhYT2FuQG1sm59JvmWN4dRH8sYF+
         CNDj4fCWtq6d515i1MT2nXWwrKLtUxoXRP28leigZoAlMKCQZfwrevCXRR42W2NvZS3C
         dWq76YGO0Dgi2k/pTxWvTzHs2xD3XROIo3R6mst38mAsCAtNRWtDfurMgMXndL3L6ivB
         WgFoBM3kWPUq7XcvsJu+fp/MyiWsFKFRUlGbOzTfAHckJcIHz4T+y28Fr7k8W57ka/zG
         na/A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=DCM6FxYZyS6beAWYcpz3SG1KyCiTppRHhDOeFEWDQGA=;
        b=US0sqBn9GYUsWYMag5Uo2lbDUiwMhEJKXovw1sANc5/WTxdVIZo4OdAiy09sQUaFpK
         wKzXukd+1zVIQZ2BALSMd8ZeUX8c6illLSGvuJaz9h3yamrIPibec3hoO1dO512lix6l
         s3zdNX+V5rtDrri3mjCa3pVTE/UrJ/tcXRk7T2XcxrnyXXqFFtUcKaQA6H/C5fvQvaZW
         H0Mhwo58gcWE9B/M1Y2VAhymImT8R59K4DYQSjMXMz989F17yUjDx4OzyGzo2phFQGZx
         kgAdY70sd1yrWk+arvFy84oddq5nwGJfyj04QYMEYcMxHj0ZBtvsWTbxA9fEsso2E/vG
         m4QA==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mvxlzcmj;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:4001:c0b::22c as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x224RweX+sLpqAsuG4GIjbZAFrjuo+tfYizVtJxImjmpCXyxcPgPoEoNgjDVGt+hw9ziH6CGNzw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519305218; cv=none;
        d=google.com; s=arc-20160816;
        b=jRt57L2lmXG2jVhBH90/3/so0JKnHGYY5WmjvCW8WsR66Vk/L/EkPm51wgUS5OiG7w
         Fkx5NYCJmPkGZ9RxUFczMEoWqDJF9Bt4sIS7DmnaPsRXtQukhP5rKvYYpW8YhID1GAf4
         0mlAcm4iqfuu97gOwtGmdiuMo933O1NS2oQ9qJzXetl6OEGuGvOa8O5ez5bnqat0dm6N
         AMOe9t+CoD+9XOY+UbGPz1ngk/yLH7PjHcz0lLkerbxopMt4u124F9vB9UVmOt+JPp3J
         TebWtxp4QHL2Md6ZX23rWuaHa0lVwrzTxH/zogup8FoEcoH9vM4GNoivPg+z/SjYaX1v
         +1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=iikUOb1+E8tACQ0lJo0eN+RGsjfPuHRLswrg2r6FRfY=;
        b=MletZWIKZhG9kk0qVOl7Yi1w2vqeCizVBxIXGG/3PHbR2kCboT+jgGts+NujlTvXHF
         /AJSmegYaJPXKCgqeJVi+cHSVIS65Bn72fVHtRh9fqkwcSfGDRDZsp7CHHe0SU0wmwcF
         UBqK2XtSWyWuLhaALBQT/ecGmGHAcL7mD8EXgPNyQatJWN4Yfq9R/NfaTEzf+DKmVGGo
         D6/+9B3fNFkJFO2GQAsl/YOLBcPwQgp7mv2SQixGWvu1eul9knaQcaxNZcND8q3PskuR
         TV6tHaC4WKuLVXLooRnW/WHLV+qdjKfBXHwks4uoRaknNVM3grTbwD7OdGxF1yXF0Grq
         u21Q==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mvxlzcmj;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:4001:c0b::22c as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Message-ID: <1519305211.2731.1.camel@gmail.com>
Subject: [Outreachy kernel] Re: [PATCH NAND v3] mtd: nand: Replace printk()
 with appropriate pr_*() macro
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
  computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr,  maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar,  outreachy-kernel@googlegroups.com
Date: Thu, 22 Feb 2018 18:43:31 +0530
In-Reply-To: <1519305014-2547-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1519305014-2547-1-git-send-email-shreeya.patel23498@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Original-Sender: shreeya.patel23498@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=mvxlzcmj;       spf=pass
 (google.com: domain of shreeya.patel23498@gmail.com designates
 2607:f8b0:4001:c0b::22c as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593106783204445682?=
X-GMAIL-MSGID: =?utf-8?q?1593106990008856606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-22 at 18:40 +0530, Shreeya Patel wrote:
> The log levels embedded with the name are more concise than
> printk.
> Replace printks having a log level with the appropriate
> pr_*macro.
> Define pr_fmt() and remove other additional macros from
> some of the replaced printks.
>=20
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>=20
> Changes in v2
> =C2=A0 -Merge previous patches of the patchset regarding replacement
> of printk with pr_*macro, into single patch.
>=20
> Changes in v3
> =C2=A0 -Define pr_fmt() and remove other additional macros from
> some of the replaced printks. Also add some more changed printks
> to pr_*() macro into the patch.
>=20
> =C2=A0drivers/mtd/nand/ams-delta.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A04 +--
> =C2=A0drivers/mtd/nand/cafe_nand.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A04 +--
> =C2=A0drivers/mtd/nand/cs553x_nand.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A09 ++--=
-
> =C2=A0drivers/mtd/nand/diskonchip.c=C2=A0=C2=A0=C2=A0=C2=A0| 76 +++++++++=
++++++++++++---------
> ----------
> =C2=A0drivers/mtd/nand/fsl_elbc_nand.c |=C2=A0=C2=A04 +--
> =C2=A0drivers/mtd/nand/fsl_ifc_nand.c=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0drivers/mtd/nand/mxc_nand.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A02 +-
> =C2=A0drivers/mtd/nand/nand_bch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 12=
 +++----
> =C2=A0drivers/mtd/nand/nandsim.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 15 ++++----
> =C2=A0drivers/mtd/nand/r852.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A05 ++-
> =C2=A0drivers/mtd/nand/r852.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A08 ++---
> =C2=A0drivers/mtd/nand/sh_flctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A02 +-
> =C2=A0drivers/mtd/nand/sm_common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A05 ++-
> =C2=A013 files changed, 77 insertions(+), 71 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-
> delta.c
> index dcec9cf..e120ce9 100644
> --- a/drivers/mtd/nand/ams-delta.c
> +++ b/drivers/mtd/nand/ams-delta.c
> @@ -185,7 +185,7 @@ static int ams_delta_init(struct platform_device
> *pdev)
> =C2=A0	/* Allocate memory for MTD device structure and private data
> */
> =C2=A0	this =3D kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
> =C2=A0	if (!this) {
> -		printk (KERN_WARNING "Unable to allocate E3 NAND MTD
> device structure.\n");
> +		pr_warn("Unable to allocate E3 NAND MTD device
> structure.\n");
> =C2=A0		err =3D -ENOMEM;
> =C2=A0		goto out;
> =C2=A0	}
> @@ -219,7 +219,7 @@ static int ams_delta_init(struct platform_device
> *pdev)
> =C2=A0		this->dev_ready =3D ams_delta_nand_ready;
> =C2=A0	} else {
> =C2=A0		this->dev_ready =3D NULL;
> -		printk(KERN_NOTICE "Couldn't request gpio for Delta
> NAND ready.\n");
> +		pr_notice("Couldn't request gpio for Delta NAND
> ready.\n");
> =C2=A0	}
> =C2=A0	/* 25 us command delay time */
> =C2=A0	this->chip_delay =3D 30;
> diff --git a/drivers/mtd/nand/cafe_nand.c
> b/drivers/mtd/nand/cafe_nand.c
> index bc558c4..1e84a6e 100644
> --- a/drivers/mtd/nand/cafe_nand.c
> +++ b/drivers/mtd/nand/cafe_nand.c
> @@ -773,8 +773,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
> =C2=A0		cafe->nand.bbt_td =3D &cafe_bbt_main_descr_512;
> =C2=A0		cafe->nand.bbt_md =3D &cafe_bbt_mirror_descr_512;
> =C2=A0	} else {
> -		printk(KERN_WARNING "Unexpected NAND flash writesize
> %d. Aborting\n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtd->writesize);
> +		pr_warn("Unexpected NAND flash writesize %d.
> Aborting\n",
> +			mtd->writesize);
> =C2=A0		goto out_free_dma;
> =C2=A0	}
> =C2=A0	cafe->nand.ecc.mode =3D NAND_ECC_HW_SYNDROME;
> diff --git a/drivers/mtd/nand/cs553x_nand.c
> b/drivers/mtd/nand/cs553x_nand.c
> index d488775..1fe3c8a 100644
> --- a/drivers/mtd/nand/cs553x_nand.c
> +++ b/drivers/mtd/nand/cs553x_nand.c
> @@ -189,10 +189,11 @@ static int __init cs553x_init_one(int cs, int
> mmio, unsigned long adr)
> =C2=A0	struct nand_chip *this;
> =C2=A0	struct mtd_info *new_mtd;
> =C2=A0
> -	printk(KERN_NOTICE "Probing CS553x NAND controller CS#%d at
> %sIO 0x%08lx\n", cs, mmio?"MM":"P", adr);
> +	pr_notice("Probing CS553x NAND controller CS#%d at %sIO
> 0x%08lx\n",
> +		=C2=A0=C2=A0cs, mmio?"MM":"P", adr);
> =C2=A0
> =C2=A0	if (!mmio) {
> -		printk(KERN_NOTICE "PIO mode not yet implemented for
> CS553X NAND controller\n");
> +		pr_notice("PIO mode not yet implemented for CS553X
> NAND controller\n");
> =C2=A0		return -ENXIO;
> =C2=A0	}
> =C2=A0
> @@ -211,7 +212,7 @@ static int __init cs553x_init_one(int cs, int
> mmio, unsigned long adr)
> =C2=A0	/* map physical address */
> =C2=A0	this->IO_ADDR_R =3D this->IO_ADDR_W =3D ioremap(adr, 4096);
> =C2=A0	if (!this->IO_ADDR_R) {
> -		printk(KERN_WARNING "ioremap cs553x NAND @0x%08lx
> failed\n", adr);
> +		pr_warn("ioremap cs553x NAND @0x%08lx failed\n",
> adr);
> =C2=A0		err =3D -EIO;
> =C2=A0		goto out_mtd;
> =C2=A0	}
> @@ -295,7 +296,7 @@ static int __init cs553x_init(void)
> =C2=A0	/* If it doesn't have the NAND controller enabled, abort */
> =C2=A0	rdmsrl(MSR_DIVIL_BALL_OPTS, val);
> =C2=A0	if (val & PIN_OPT_IDE) {
> -		printk(KERN_INFO "CS553x NAND controller: Flash I/O
> not enabled in MSR_DIVIL_BALL_OPTS.\n");
> +		pr_info("CS553x NAND controller: Flash I/O not
> enabled in MSR_DIVIL_BALL_OPTS.\n");
> =C2=A0		return -ENXIO;
> =C2=A0	}
> =C2=A0
> diff --git a/drivers/mtd/nand/diskonchip.c
> b/drivers/mtd/nand/diskonchip.c
> index c3aa53c..8643512 100644
> --- a/drivers/mtd/nand/diskonchip.c
> +++ b/drivers/mtd/nand/diskonchip.c
> @@ -411,7 +411,7 @@ static uint16_t __init doc200x_ident_chip(struct
> mtd_info *mtd, int nr)
> =C2=A0
> =C2=A0		ident.dword =3D readl(docptr + DoC_2k_CDSN_IO);
> =C2=A0		if (((ident.byte[0] << 8) | ident.byte[1]) =3D=3D ret) {
> -			printk(KERN_INFO "DiskOnChip 2000 responds
> to DWORD access\n");
> +			pr_info("DiskOnChip 2000 responds to DWORD
> access\n");
> =C2=A0			this->read_buf =3D &doc2000_readbuf_dword;
> =C2=A0		}
> =C2=A0	}
> @@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct
> mtd_info *mtd)
> =C2=A0			break;
> =C2=A0	}
> =C2=A0	doc->chips_per_floor =3D i;
> -	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
> +	pr_debug("Detected %d chips per floor.\n", i);
> =C2=A0}
> =C2=A0
> =C2=A0static int doc200x_wait(struct mtd_info *mtd, struct nand_chip
> *this)
> @@ -935,14 +935,15 @@ static int doc200x_correct_data(struct mtd_info
> *mtd, u_char *dat,
> =C2=A0
> =C2=A0		ret =3D doc_ecc_decode(rs_decoder, dat, calc_ecc);
> =C2=A0		if (ret > 0)
> -			printk(KERN_ERR "doc200x_correct_data
> corrected %d errors\n", ret);
> +			pr_err("doc200x_correct_data corrected %d
> errors\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret);
> =C2=A0	}
> =C2=A0	if (DoC_is_MillenniumPlus(doc))
> =C2=A0		WriteDOC(DOC_ECC_DIS, docptr, Mplus_ECCConf);
> =C2=A0	else
> =C2=A0		WriteDOC(DOC_ECC_DIS, docptr, ECCConf);
> =C2=A0	if (no_ecc_failures && mtd_is_eccerr(ret)) {
> -		printk(KERN_ERR "suppressing ECC failure\n");
> +		pr_err("suppressing ECC failure\n");
> =C2=A0		ret =3D 0;
> =C2=A0	}
> =C2=A0	return ret;
> @@ -1015,11 +1016,11 @@ static int __init find_media_headers(struct
> mtd_info *mtd, u_char *buf, const ch
> =C2=A0		if (retlen !=3D mtd->writesize)
> =C2=A0			continue;
> =C2=A0		if (ret) {
> -			printk(KERN_WARNING "ECC error scanning DOC
> at 0x%x\n", offs);
> +			pr_warn("ECC error scanning DOC at 0x%x\n",
> offs);
> =C2=A0		}
> =C2=A0		if (memcmp(buf, id, 6))
> =C2=A0			continue;
> -		printk(KERN_INFO "Found DiskOnChip %s Media Header
> at 0x%x\n", id, offs);
> +		pr_info("Found DiskOnChip %s Media Header at
> 0x%x\n", id, offs);
> =C2=A0		if (doc->mh0_page =3D=3D -1) {
> =C2=A0			doc->mh0_page =3D offs >> this->page_shift;
> =C2=A0			if (!findmirror)
> @@ -1030,7 +1031,7 @@ static int __init find_media_headers(struct
> mtd_info *mtd, u_char *buf, const ch
> =C2=A0		return 2;
> =C2=A0	}
> =C2=A0	if (doc->mh0_page =3D=3D -1) {
> -		printk(KERN_WARNING "DiskOnChip %s Media Header not
> found.\n", id);
> +		pr_warn("DiskOnChip %s Media Header not found.\n",
> id);
> =C2=A0		return 0;
> =C2=A0	}
> =C2=A0	/* Only one mediaheader was found.=C2=A0=C2=A0We want buf to conta=
in a
> @@ -1039,7 +1040,7 @@ static int __init find_media_headers(struct
> mtd_info *mtd, u_char *buf, const ch
> =C2=A0	ret =3D mtd_read(mtd, offs, mtd->writesize, &retlen, buf);
> =C2=A0	if (retlen !=3D mtd->writesize) {
> =C2=A0		/* Insanity.=C2=A0=C2=A0Give up. */
> -		printk(KERN_ERR "Read DiskOnChip Media Header once,
> but can't reread it???\n");
> +		pr_err("Read DiskOnChip Media Header once, but can't
> reread it???\n");
> =C2=A0		return 0;
> =C2=A0	}
> =C2=A0	return 1;
> @@ -1069,11 +1070,11 @@ static inline int __init nftl_partscan(struct
> mtd_info *mtd, struct mtd_partitio
> =C2=A0	le16_to_cpus(&mh->FirstPhysicalEUN);
> =C2=A0	le32_to_cpus(&mh->FormattedSize);
> =C2=A0
> -	printk(KERN_INFO "=C2=A0=C2=A0=C2=A0=C2=A0DataOrgID=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %s\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0NumEraseUnits=C2=A0=C2=A0=C2=A0=C2=A0=
=3D %d\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0FirstPhysicalEUN =3D %d\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0FormattedSize=C2=A0=C2=A0=C2=A0=C2=A0=
=3D %d\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0UnitSizeFactor=C2=A0=C2=A0=C2=A0=3D %d=
\n",
> +	pr_info("=C2=A0=C2=A0=C2=A0=C2=A0DataOrgID=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=3D %s\n"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0NumEraseUnits=C2=A0=C2=A0=C2=A0=C2=A0=3D %d\n=
"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0FirstPhysicalEUN =3D %d\n"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0FormattedSize=C2=A0=C2=A0=C2=A0=C2=A0=3D %d\n=
"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0UnitSizeFactor=C2=A0=C2=A0=C2=A0=3D %d\n",
> =C2=A0		mh->DataOrgID, mh->NumEraseUnits,
> =C2=A0		mh->FirstPhysicalEUN, mh->FormattedSize,
> =C2=A0		mh->UnitSizeFactor);
> @@ -1093,7 +1094,7 @@ static inline int __init nftl_partscan(struct
> mtd_info *mtd, struct mtd_partitio
> =C2=A0			maxblocks =3D min(32768U, (maxblocks << 1) +
> psize);
> =C2=A0			mh->UnitSizeFactor--;
> =C2=A0		}
> -		printk(KERN_WARNING "UnitSizeFactor=3D0x00
> detected.=C2=A0=C2=A0Correct value is assumed to be 0x%02x.\n", mh-
> >UnitSizeFactor);
> +		pr_warn("UnitSizeFactor=3D0x00 detected.=C2=A0=C2=A0Correct
> value is assumed to be 0x%02x.\n", mh->UnitSizeFactor);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* NOTE: The lines below modify internal variables of the
> NAND and MTD
> @@ -1104,13 +1105,13 @@ static inline int __init nftl_partscan(struct
> mtd_info *mtd, struct mtd_partitio
> =C2=A0	if (mh->UnitSizeFactor !=3D 0xff) {
> =C2=A0		this->bbt_erase_shift +=3D (0xff - mh-
> >UnitSizeFactor);
> =C2=A0		mtd->erasesize <<=3D (0xff - mh->UnitSizeFactor);
> -		printk(KERN_INFO "Setting virtual erase size to
> %d\n", mtd->erasesize);
> +		pr_info("Setting virtual erase size to %d\n", mtd-
> >erasesize);
> =C2=A0		blocks =3D mtd->size >> this->bbt_erase_shift;
> =C2=A0		maxblocks =3D min(32768U, mtd->erasesize - psize);
> =C2=A0	}
> =C2=A0
> =C2=A0	if (blocks > maxblocks) {
> -		printk(KERN_ERR "UnitSizeFactor of 0x%02x is
> inconsistent with device size.=C2=A0=C2=A0Aborting.\n", mh->UnitSizeFacto=
r);
> +		pr_err("UnitSizeFactor of 0x%02x is inconsistent
> with device size.=C2=A0=C2=A0Aborting.\n", mh->UnitSizeFactor);
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> @@ -1181,14 +1182,14 @@ static inline int __init
> inftl_partscan(struct mtd_info *mtd, struct mtd_partiti
> =C2=A0	le32_to_cpus(&mh->FormatFlags);
> =C2=A0	le32_to_cpus(&mh->PercentUsed);
> =C2=A0
> -	printk(KERN_INFO "=C2=A0=C2=A0=C2=A0=C2=A0bootRecordID=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %s\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0NoOfBootImageBlocks=C2=A0=C2=A0=C2=A0=
=3D %d\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0NoOfBinaryPartitions=C2=A0=C2=A0=3D %d=
\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0NoOfBDTLPartitions=C2=A0=C2=A0=C2=A0=
=C2=A0=3D %d\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0BlockMultiplerBits=C2=A0=C2=A0=C2=A0=
=C2=A0=3D %d\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0FormatFlgs=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %d\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0OsakVersion=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %d.%d.%d.%d\n"
> -			=C2=A0"=C2=A0=C2=A0=C2=A0=C2=A0PercentUsed=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %d\n",
> +	pr_info("=C2=A0=C2=A0=C2=A0=C2=A0bootRecordID=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %s\n"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0NoOfBootImageBlocks=C2=A0=C2=A0=C2=A0=3D %d\n=
"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0NoOfBinaryPartitions=C2=A0=C2=A0=3D %d\n"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0NoOfBDTLPartitions=C2=A0=C2=A0=C2=A0=C2=A0=3D=
 %d\n"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0BlockMultiplerBits=C2=A0=C2=A0=C2=A0=C2=A0=3D=
 %d\n"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0FormatFlgs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %d\n"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0OsakVersion=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %d.%d.%d.%d\n"
> +		"=C2=A0=C2=A0=C2=A0=C2=A0PercentUsed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %d\n",
> =C2=A0		mh->bootRecordID, mh->NoOfBootImageBlocks,
> =C2=A0		mh->NoOfBinaryPartitions,
> =C2=A0		mh->NoOfBDTLPartitions,
> @@ -1203,13 +1204,13 @@ static inline int __init
> inftl_partscan(struct mtd_info *mtd, struct mtd_partiti
> =C2=A0
> =C2=A0	blocks =3D mtd->size >> vshift;
> =C2=A0	if (blocks > 32768) {
> -		printk(KERN_ERR "BlockMultiplierBits=3D%d is
> inconsistent with device size.=C2=A0=C2=A0Aborting.\n", mh-
> >BlockMultiplierBits);
> +		pr_err("BlockMultiplierBits=3D%d is inconsistent with
> device size.=C2=A0=C2=A0Aborting.\n", mh->BlockMultiplierBits);
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> =C2=A0	blocks =3D doc->chips_per_floor << (this->chip_shift - this-
> >phys_erase_shift);
> =C2=A0	if (inftl_bbt_write && (blocks > mtd->erasesize)) {
> -		printk(KERN_ERR "Writeable BBTs spanning more than
> one erase block are not yet supported.=C2=A0=C2=A0FIX ME!\n");
> +		pr_err("Writeable BBTs spanning more than one erase
> block are not yet supported.=C2=A0=C2=A0FIX ME!\n");
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> @@ -1223,7 +1224,7 @@ static inline int __init inftl_partscan(struct
> mtd_info *mtd, struct mtd_partiti
> =C2=A0		le32_to_cpus(&ip->spareUnits);
> =C2=A0		le32_to_cpus(&ip->Reserved0);
> =C2=A0
> -		printk(KERN_INFO	"=C2=A0=C2=A0=C2=A0=C2=A0PARTITION[%d] ->\n"
> +		pr_info("=C2=A0=C2=A0=C2=A0=C2=A0PARTITION[%d] ->\n"
> =C2=A0			"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0virtualUnits=C2=
=A0=C2=A0=C2=A0=C2=A0=3D %d\n"
> =C2=A0			"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0firstUnit=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %d\n"
> =C2=A0			"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lastUnit=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D %d\n"
> @@ -1309,7 +1310,7 @@ static int __init inftl_scan_bbt(struct
> mtd_info *mtd)
> =C2=A0	struct mtd_partition parts[5];
> =C2=A0
> =C2=A0	if (this->numchips > doc->chips_per_floor) {
> -		printk(KERN_ERR "Multi-floor INFTL devices not yet
> supported.\n");
> +		pr_err("Multi-floor INFTL devices not yet
> supported.\n");
> =C2=A0		return -EIO;
> =C2=A0	}
> =C2=A0
> @@ -1437,7 +1438,8 @@ static int __init doc_probe(unsigned long
> physadr)
> =C2=A0		return -EBUSY;
> =C2=A0	virtadr =3D ioremap(physadr, DOC_IOREMAP_LEN);
> =C2=A0	if (!virtadr) {
> -		printk(KERN_ERR "Diskonchip ioremap failed: 0x%x
> bytes at 0x%lx\n", DOC_IOREMAP_LEN, physadr);
> +		pr_err("Diskonchip ioremap failed: 0x%x bytes at
> 0x%lx\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DOC_IOREMAP_LEN, physadr);
> =C2=A0		ret =3D -EIO;
> =C2=A0		goto error_ioremap;
> =C2=A0	}
> @@ -1496,7 +1498,7 @@ static int __init doc_probe(unsigned long
> physadr)
> =C2=A0			reg =3D DoC_Mplus_Toggle;
> =C2=A0			break;
> =C2=A0		case DOC_ChipID_DocMilPlus32:
> -			printk(KERN_ERR "DiskOnChip Millennium Plus
> 32MB is not supported, ignoring.\n");
> +			pr_err("DiskOnChip Millennium Plus 32MB is
> not supported, ignoring.\n");
> =C2=A0		default:
> =C2=A0			ret =3D -ENODEV;
> =C2=A0			goto notfound;
> @@ -1512,7 +1514,7 @@ static int __init doc_probe(unsigned long
> physadr)
> =C2=A0	tmpb =3D ReadDOC_(virtadr, reg) & DOC_TOGGLE_BIT;
> =C2=A0	tmpc =3D ReadDOC_(virtadr, reg) & DOC_TOGGLE_BIT;
> =C2=A0	if ((tmp =3D=3D tmpb) || (tmp !=3D tmpc)) {
> -		printk(KERN_WARNING "Possible DiskOnChip at 0x%lx
> failed TOGGLE test, dropping.\n", physadr);
> +		pr_warn("Possible DiskOnChip at 0x%lx failed TOGGLE
> test, dropping.\n", physadr);
> =C2=A0		ret =3D -ENODEV;
> =C2=A0		goto notfound;
> =C2=A0	}
> @@ -1546,12 +1548,13 @@ static int __init doc_probe(unsigned long
> physadr)
> =C2=A0		}
> =C2=A0		newval =3D ~newval;
> =C2=A0		if (oldval =3D=3D newval) {
> -			printk(KERN_DEBUG "Found alias of DOC at
> 0x%lx to 0x%lx\n", doc->physadr, physadr);
> +			pr_debug("Found alias of DOC at 0x%lx to
> 0x%lx\n",
> +				=C2=A0doc->physadr, physadr);
> =C2=A0			goto notfound;
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	printk(KERN_NOTICE "DiskOnChip found at 0x%lx\n", physadr);
> +	pr_notice("DiskOnChip found at 0x%lx\n", physadr);
> =C2=A0
> =C2=A0	len =3D sizeof(struct nand_chip) + sizeof(struct doc_priv) +
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(2 * sizeof(struct nand_bbt_de=
scr));
> @@ -1666,12 +1669,13 @@ static int __init init_nanddoc(void)
> =C2=A0	=C2=A0*/
> =C2=A0	rs_decoder =3D init_rs(10, 0x409, FCR, 1, NROOTS);
> =C2=A0	if (!rs_decoder) {
> -		printk(KERN_ERR "DiskOnChip: Could not create a RS
> decoder\n");
> +		pr_err("DiskOnChip: Could not create a RS
> decoder\n");
> =C2=A0		return -ENOMEM;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (doc_config_location) {
> -		printk(KERN_INFO "Using configured DiskOnChip probe
> address 0x%lx\n", doc_config_location);
> +		pr_info("Using configured DiskOnChip probe address
> 0x%lx\n",
> +			doc_config_location);
> =C2=A0		ret =3D doc_probe(doc_config_location);
> =C2=A0		if (ret < 0)
> =C2=A0			goto outerr;
> @@ -1683,7 +1687,7 @@ static int __init init_nanddoc(void)
> =C2=A0	/* No banner message any more. Print a message if no
> DiskOnChip
> =C2=A0	=C2=A0=C2=A0=C2=A0found, so the user knows we at least tried. */
> =C2=A0	if (!doclist) {
> -		printk(KERN_INFO "No valid DiskOnChip devices
> found\n");
> +		pr_info("No valid DiskOnChip devices found\n");
> =C2=A0		ret =3D -ENODEV;
> =C2=A0		goto outerr;
> =C2=A0	}
> diff --git a/drivers/mtd/nand/fsl_elbc_nand.c
> b/drivers/mtd/nand/fsl_elbc_nand.c
> index 17db2f9..396216c2 100644
> --- a/drivers/mtd/nand/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/fsl_elbc_nand.c
> @@ -929,8 +929,8 @@ static int fsl_elbc_nand_probe(struct
> platform_device *pdev)
> =C2=A0	mtd_device_parse_register(mtd, part_probe_types, NULL,
> =C2=A0				=C2=A0=C2=A0NULL, 0);
> =C2=A0
> -	printk(KERN_INFO "eLBC NAND device at 0x%llx, bank %d\n",
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(unsigned long long)res.start=
, priv->bank);
> +	pr_info("eLBC NAND device at 0x%llx, bank %d\n",
> +		(unsigned long long)res.start, priv->bank);
> =C2=A0	return 0;
> =C2=A0
> =C2=A0err:
> diff --git a/drivers/mtd/nand/fsl_ifc_nand.c
> b/drivers/mtd/nand/fsl_ifc_nand.c
> index 9e03bac..f88a493 100644
> --- a/drivers/mtd/nand/fsl_ifc_nand.c
> +++ b/drivers/mtd/nand/fsl_ifc_nand.c
> @@ -805,7 +805,7 @@ static void fsl_ifc_sram_init(struct fsl_ifc_mtd
> *priv)
> =C2=A0			=C2=A0=C2=A0=C2=A0msecs_to_jiffies(IFC_TIMEOUT_MSECS));
> =C2=A0
> =C2=A0	if (ctrl->nand_stat !=3D IFC_NAND_EVTER_STAT_OPC)
> -		printk(KERN_ERR "fsl-ifc: Failed to Initialise
> SRAM\n");
> +		pr_err("fsl-ifc: Failed to Initialise SRAM\n");
> =C2=A0
> =C2=A0	/* Restore CSOR and CSOR_ext */
> =C2=A0	ifc_out32(csor, &ifc_global->csor_cs[cs].csor);
> diff --git a/drivers/mtd/nand/mxc_nand.c
> b/drivers/mtd/nand/mxc_nand.c
> index 53e5e03..e99c272 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -634,7 +634,7 @@ static int mxc_nand_correct_data_v2_v3(struct
> mtd_info *mtd, u_char *dat,
> =C2=A0	do {
> =C2=A0		err =3D ecc_stat & ecc_bit_mask;
> =C2=A0		if (err > err_limit) {
> -			printk(KERN_WARNING "UnCorrectable RS-ECC
> Error\n");
> +			pr_warn("UnCorrectable RS-ECC Error\n");
> =C2=A0			return -EBADMSG;
> =C2=A0		} else {
> =C2=A0			ret +=3D err;
> diff --git a/drivers/mtd/nand/nand_bch.c
> b/drivers/mtd/nand/nand_bch.c
> index 505441c..7f11b68 100644
> --- a/drivers/mtd/nand/nand_bch.c
> +++ b/drivers/mtd/nand/nand_bch.c
> @@ -95,7 +95,7 @@ int nand_bch_correct_data(struct mtd_info *mtd,
> unsigned char *buf,
> =C2=A0					errloc[i]);
> =C2=A0		}
> =C2=A0	} else if (count < 0) {
> -		printk(KERN_ERR "ecc unrecoverable error\n");
> +		pr_err("ecc unrecoverable error\n");
> =C2=A0		count =3D -EBADMSG;
> =C2=A0	}
> =C2=A0	return count;
> @@ -134,7 +134,7 @@ struct nand_bch_control *nand_bch_init(struct
> mtd_info *mtd)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!eccsize || !eccbytes) {
> -		printk(KERN_WARNING "ecc parameters not
> supplied\n");
> +		pr_warn("ecc parameters not supplied\n");
> =C2=A0		goto fail;
> =C2=A0	}
> =C2=A0
> @@ -151,8 +151,8 @@ struct nand_bch_control *nand_bch_init(struct
> mtd_info *mtd)
> =C2=A0
> =C2=A0	/* verify that eccbytes has the expected value */
> =C2=A0	if (nbc->bch->ecc_bytes !=3D eccbytes) {
> -		printk(KERN_WARNING "invalid eccbytes %u, should be
> %u\n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0eccbytes, nbc->bch->ecc_byte=
s);
> +		pr_warn("invalid eccbytes %u, should be %u\n",
> +			eccbytes, nbc->bch->ecc_bytes);
> =C2=A0		goto fail;
> =C2=A0	}
> =C2=A0
> @@ -166,7 +166,7 @@ struct nand_bch_control *nand_bch_init(struct
> mtd_info *mtd)
> =C2=A0
> =C2=A0	/* sanity checks */
> =C2=A0	if (8*(eccsize+eccbytes) >=3D (1 << m)) {
> -		printk(KERN_WARNING "eccsize %u is too large\n",
> eccsize);
> +		pr_warn("eccsize %u is too large\n", eccsize);
> =C2=A0		goto fail;
> =C2=A0	}
> =C2=A0
> @@ -181,7 +181,7 @@ struct nand_bch_control *nand_bch_init(struct
> mtd_info *mtd)
> =C2=A0	nand->ecc.steps =3D eccsteps;
> =C2=A0	nand->ecc.total =3D eccsteps * eccbytes;
> =C2=A0	if (mtd_ooblayout_count_eccbytes(mtd) !=3D
> (eccsteps*eccbytes)) {
> -		printk(KERN_WARNING "invalid ecc layout\n");
> +		pr_warn("invalid ecc layout\n");
> =C2=A0		goto fail;
> =C2=A0	}
> =C2=A0
> diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
> index 246b439..eeb34ef 100644
> --- a/drivers/mtd/nand/nandsim.c
> +++ b/drivers/mtd/nand/nandsim.c
> @@ -23,6 +23,8 @@
> =C2=A0 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-
> 1307, USA
> =C2=A0 */
> =C2=A0
> +#define pr_fmt(fmt)=C2=A0=C2=A0"[nandsim]" fmt
> +
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/module.h>
> @@ -179,20 +181,17 @@ MODULE_PARM_DESC(bch,		=C2=A0"Enable
> BCH ecc and set how many bits should "
> =C2=A0/* The largest possible page size */
> =C2=A0#define NS_LARGEST_PAGE_SIZE	4096
> =C2=A0
> -/* The prefix for simulator output */
> -#define NS_OUTPUT_PREFIX "[nandsim]"
> -
> =C2=A0/* Simulator's output macros (logging, debugging, warning, error) *=
/
> =C2=A0#define NS_LOG(args...) \
> -	do { if (log) printk(KERN_DEBUG NS_OUTPUT_PREFIX " log: "
> args); } while(0)
> +	do { if (log) pr_debug(" log: " args); } while(0)
> =C2=A0#define NS_DBG(args...) \
> -	do { if (dbg) printk(KERN_DEBUG NS_OUTPUT_PREFIX " debug: "
> args); } while(0)
> +	do { if (dbg) pr_debug(" debug: " args); } while(0)
> =C2=A0#define NS_WARN(args...) \
> -	do { printk(KERN_WARNING NS_OUTPUT_PREFIX " warning: "
> args); } while(0)
> +	do { pr_warn(" warning: " args); } while(0)
> =C2=A0#define NS_ERR(args...) \
> -	do { printk(KERN_ERR NS_OUTPUT_PREFIX " error: " args); }
> while(0)
> +	do { pr_err(" error: " args); } while(0)
> =C2=A0#define NS_INFO(args...) \
> -	do { printk(KERN_INFO NS_OUTPUT_PREFIX " " args); } while(0)
> +	do { pr_info(" " args); } while(0)
> =C2=A0
> =C2=A0/* Busy-wait delay macros (microseconds, milliseconds) */
> =C2=A0#define NS_UDELAY(us) \
> diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
> index fc9287a..cd3cd1c 100644
> --- a/drivers/mtd/nand/r852.c
> +++ b/drivers/mtd/nand/r852.c
> @@ -7,6 +7,9 @@
> =C2=A0 * published by the Free Software Foundation.
> =C2=A0 */
> =C2=A0
> +#define DRV_NAME "r852"
> +#define pr_fmt(fmt)=C2=A0=C2=A0DRV_NAME fmt

I've done this kind of change for the first time.
So please guide me if I am wrong here or if I made
things more complex.

Thanks

> +
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/jiffies.h>
> @@ -935,7 +938,7 @@ static int=C2=A0=C2=A0r852_probe(struct pci_dev *pci_=
dev,
> const struct pci_device_id *id)
> =C2=A0		&dev->card_detect_work, 0);
> =C2=A0
> =C2=A0
> -	printk(KERN_NOTICE DRV_NAME ": driver loaded
> successfully\n");
> +	pr_notice(": driver loaded successfully\n");
> =C2=A0	return 0;
> =C2=A0
> =C2=A0error10:
> diff --git a/drivers/mtd/nand/r852.h b/drivers/mtd/nand/r852.h
> index 8713c57..709eced 100644
> --- a/drivers/mtd/nand/r852.h
> +++ b/drivers/mtd/nand/r852.h
> @@ -145,16 +145,16 @@ struct r852_device {
> =C2=A0};
> =C2=A0
> =C2=A0#define DRV_NAME "r852"
> -
> +#define pr_fmt(fmt)=C2=A0=C2=A0DRV_NAME fmt
> =C2=A0
> =C2=A0#define dbg(format, ...) \
> =C2=A0	if (debug) \
> -		printk(KERN_DEBUG DRV_NAME ": " format "\n", ##
> __VA_ARGS__)
> +		pr_debug(": " format "\n", ## __VA_ARGS__)
> =C2=A0
> =C2=A0#define dbg_verbose(format, ...) \
> =C2=A0	if (debug > 1) \
> -		printk(KERN_DEBUG DRV_NAME ": " format "\n", ##
> __VA_ARGS__)
> +		pr_debug(": " format "\n", ## __VA_ARGS__)
> =C2=A0
> =C2=A0
> =C2=A0#define message(format, ...) \
> -	printk(KERN_INFO DRV_NAME ": " format "\n", ## __VA_ARGS__)
> +	pr_info(": " format "\n", ## __VA_ARGS__)
> diff --git a/drivers/mtd/nand/sh_flctl.c
> b/drivers/mtd/nand/sh_flctl.c
> index e7f3c98..493f6b2 100644
> --- a/drivers/mtd/nand/sh_flctl.c
> +++ b/drivers/mtd/nand/sh_flctl.c
> @@ -877,7 +877,7 @@ static void flctl_cmdfunc(struct mtd_info *mtd,
> unsigned int command,
> =C2=A0			else if (!flctl->seqin_column)
> =C2=A0				execmd_write_page_sector(mtd);
> =C2=A0			else
> -				printk(KERN_ERR "Invalid address
> !?\n");
> +				pr_err("Invalid address !?\n");
> =C2=A0			break;
> =C2=A0		}
> =C2=A0		set_cmd_regs(mtd, command, (command << 8) |
> NAND_CMD_SEQIN);
> diff --git a/drivers/mtd/nand/sm_common.c
> b/drivers/mtd/nand/sm_common.c
> index c378705..7f5044a 100644
> --- a/drivers/mtd/nand/sm_common.c
> +++ b/drivers/mtd/nand/sm_common.c
> @@ -119,9 +119,8 @@ static int sm_block_markbad(struct mtd_info *mtd,
> loff_t ofs)
> =C2=A0
> =C2=A0	ret =3D mtd_write_oob(mtd, ofs, &ops);
> =C2=A0	if (ret < 0 || ops.oobretlen !=3D SM_OOB_SIZE) {
> -		printk(KERN_NOTICE
> -			"sm_common: can't mark sector at %i as
> bad\n",
> -								(int
> )ofs);
> +		pr_notice("sm_common: can't mark sector at %i as
> bad\n",
> +			=C2=A0=C2=A0(int)ofs);
> =C2=A0		return -EIO;
> =C2=A0	}
> =C2=A0

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/1519305211.2731.1.camel%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
