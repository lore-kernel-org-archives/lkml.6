Return-Path: <fbarrat@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZrUOl3O/t9ThcTjOeYsw3gjwCfajmqBeMseeFZ1QusCJFjuQlYyvLitRP7EF3DwysKHgVJH
ARC-Seal: i=1; a=rsa-sha256; t=1525714744; cv=none;
        d=google.com; s=arc-20160816;
        b=vGzWj5OPQK+etp5f5WZ1Vt6bu2drrlRy9AXbFAt6yBu0js1e4Pt3fNrzaxshzFotao
         1WP0RCvVoAu9n2AVSRMwJU3YF4Tfkm311KmmAcpQl6te1B/Pivybrmb2QXsTph5IHKYQ
         HHWvXbsPC94lHMeAF1WFcC4EwdMW7tbLKWAOiOEEDFmJQKAI5xCPe2pFh2SRxt6cflZr
         uJDSvzogyRcVTTMBHFXgRK8K/dRc4urJLNVukgUPJkHQkVKZ8ZYzOsqEf/fHfEMS196m
         9FV2Kng3HlsTaXkmhbiDBDL7L3yUSwIGD03Ikhhv3wnxYzeA7upilBAcF9Olx9trOOa0
         doAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=SPRyyF2GBAImC545HwFzaHN686xtynAcU4cL1/ql38Q=;
        b=fmglfELGZ+Bla1AztSD7lFLsa6q62dxMIZZSjAOZfy8P8eHpnxTICH5qzo45Q5sFi9
         BbWBWw+1uKLVgdF+FinHuqOofJ6syNsjuaZYchcQfKPRkx2vdHBU2KdPpd8cS0qZa69w
         K/wDcKQbE/4Rj8CNm8kYb6FSheZ9ReaOzWnkYmQ9Unmj2nCX/Kuzk2vmbNrd0AvkM7cv
         OEMUwKT0XRL/kQHOx8a/zKpa346MEKMZx6F/tyGe5NEK+SGq2Hrwr9J+DETJCup8IXgf
         WvIbQcbtmSNg02k46oVS8TY2BObBq1iFdTnpaub5pFkgpf+h5U3gy60YfddRoMLumxuk
         KluQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 4/7] ocxl: Rename pnv_ocxl_spa_remove_pe to clarify
 it's action
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-5-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 7 May 2018 19:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-5-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050717-0020-0000-0000-0000041A0C4B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050717-0021-0000-0000-000042AF40F4
Message-Id: <80b45171-3708-d252-8f57-310f23eb18cd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070177
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957549805591967?=
X-GMAIL-MSGID: =?utf-8?q?1599827864127005282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The function removes the process element from NPU cache.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   arch/powerpc/include/asm/pnv-ocxl.h   | 2 +-
>   arch/powerpc/platforms/powernv/ocxl.c | 4 ++--
>   drivers/misc/ocxl/link.c              | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> index f6945d3bc971..208b5503f4ed 100644
> --- a/arch/powerpc/include/asm/pnv-ocxl.h
> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> @@ -28,7 +28,7 @@ extern int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
>   extern int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
>   			void **platform_data);
>   extern void pnv_ocxl_spa_release(void *platform_data);
> -extern int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle);
> +extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
> 
>   extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
>   extern void pnv_ocxl_free_xive_irq(u32 irq);
> diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
> index fa9b53af3c7b..8c65aacda9c8 100644
> --- a/arch/powerpc/platforms/powernv/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/ocxl.c
> @@ -475,7 +475,7 @@ void pnv_ocxl_spa_release(void *platform_data)
>   }
>   EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
> 
> -int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle)
> +int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
>   {
>   	struct spa_data *data = (struct spa_data *) platform_data;
>   	int rc;
> @@ -483,7 +483,7 @@ int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle)
>   	rc = opal_npu_spa_clear_cache(data->phb_opal_id, data->bdfn, pe_handle);
>   	return rc;
>   }
> -EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe);
> +EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe_from_cache);
> 
>   int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr)
>   {
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index f30790582dc0..656e8610eec2 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -599,7 +599,7 @@ int ocxl_link_remove_pe(void *link_handle, int pasid)
>   	 * On powerpc, the entry needs to be cleared from the context
>   	 * cache of the NPU.
>   	 */
> -	rc = pnv_ocxl_spa_remove_pe(link->platform_data, pe_handle);
> +	rc = pnv_ocxl_spa_remove_pe_from_cache(link->platform_data, pe_handle);
>   	WARN_ON(rc);
> 
>   	pe_data = radix_tree_delete(&spa->pe_tree, pe_handle);
> 
