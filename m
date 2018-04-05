Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeDEWcD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 18:32:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeDEWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 18:32:01 -0400
Subject: Re: [PATCH v2] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
To: Paul Durrant <paul.durrant@citrix.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
References: <20180405154249.33929-1-paul.durrant@citrix.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 xsFNBFH8CgsBEAC0KiOi9siOvlXatK2xX99e/J3OvApoYWjieVQ9232Eb7GzCWrItCzP8FUV
 PQg8rMsSd0OzIvvjbEAvaWLlbs8wa3MtVLysHY/DfqRK9Zvr/RgrsYC6ukOB7igy2PGqZd+M
 MDnSmVzik0sPvB6xPV7QyFsykEgpnHbvdZAUy/vyys8xgT0PVYR5hyvhyf6VIfGuvqIsvJw5
 C8+P71CHI+U/IhsKrLrsiYHpAhQkw+Zvyeml6XSi5w4LXDbF+3oholKYCkPwxmGdK8MUIdkM
 d7iYdKqiP4W6FKQou/lC3jvOceGupEoDV9botSWEIIlKdtm6C4GfL45RD8V4B9iy24JHPlom
 woVWc0xBZboQguhauQqrBFooHO3roEeM1pxXjLUbDtH4t3SAI3gt4dpSyT3EvzhyNQVVIxj2
 FXnIChrYxR6S0ijSqUKO0cAduenhBrpYbz9qFcB/GyxD+ZWY7OgQKHUZMWapx5bHGQ8bUZz2
 SfjZwK+GETGhfkvNMf6zXbZkDq4kKB/ywaKvVPodS1Poa44+B9sxbUp1jMfFtlOJ3AYB0WDS
 Op3d7F2ry20CIf1Ifh0nIxkQPkTX7aX5rI92oZeu5u038dHUu/dO2EcuCjl1eDMGm5PLHDSP
 0QUw5xzk1Y8MG1JQ56PtqReO33inBXG63yTIikJmUXFTw6lLJwARAQABzTNCb3JpcyBPc3Ry
 b3Zza3kgKFdvcmspIDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT7CwXgEEwECACIFAlH8
 CgsCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEIredpCGysGyasEP/j5xApopUf4g
 9Fl3UxZuBx+oduuw3JHqgbGZ2siA3EA4bKwtKq8eT7ekpApn4c0HA8TWTDtgZtLSV5IdH+9z
 JimBDrhLkDI3Zsx2CafL4pMJvpUavhc5mEU8myp4dWCuIylHiWG65agvUeFZYK4P33fGqoaS
 VGx3tsQIAr7MsQxilMfRiTEoYH0WWthhE0YVQzV6kx4wj4yLGYPPBtFqnrapKKC8yFTpgjaK
 jImqWhU9CSUAXdNEs/oKVR1XlkDpMCFDl88vKAuJwugnixjbPFTVPyoC7+4Bm/FnL3iwlJVE
 qIGQRspt09r+datFzPqSbp5Fo/9m4JSvgtPp2X2+gIGgLPWp2ft1NXHHVWP19sPgEsEJXSr9
 tskM8ScxEkqAUuDs6+x/ISX8wa5Pvmo65drN+JWA8EqKOHQG6LUsUdJolFM2i4Z0k40BnFU/
 kjTARjrXW94LwokVy4x+ZYgImrnKWeKac6fMfMwH2aKpCQLlVxdO4qvJkv92SzZz4538az1T
 m+3ekJAimou89cXwXHCFb5WqJcyjDfdQF857vTn1z4qu7udYCuuV/4xDEhslUq1+GcNDjAhB
 nNYPzD+SvhWEsrjuXv+fDONdJtmLUpKs4Jtak3smGGhZsqpcNv8nQzUGDQZjuCSmDqW8vn2o
 hWwveNeRTkxh+2x1Qb3GT46uzsFNBFH8CgsBEADGC/yx5ctcLQlB9hbq7KNqCDyZNoYu1HAB
 Hal3MuxPfoGKObEktawQPQaSTB5vNlDxKihezLnlT/PKjcXC2R1OjSDinlu5XNGc6mnky03q
 yymUPyiMtWhBBftezTRxWRslPaFWlg/h/Y1iDuOcklhpr7K1h1jRPCrf1yIoxbIpDbffnuyz
 kuto4AahRvBU4Js4sU7f/btU+h+e0AcLVzIhTVPIz7PM+Gk2LNzZ3/on4dnEc/qd+ZZFlOQ4
 KDN/hPqlwA/YJsKzAPX51L6Vv344pqTm6Z0f9M7YALB/11FO2nBB7zw7HAUYqJeHutCwxm7i
 BDNt0g9fhviNcJzagqJ1R7aPjtjBoYvKkbwNu5sWDpQ4idnsnck4YT6ctzN4I+6lfkU8zMzC
 gM2R4qqUXmxFIS4Bee+gnJi0Pc3KcBYBZsDK44FtM//5Cp9DrxRQOh19kNHBlxkmEb8kL/pw
 XIDcEq8MXzPBbxwHKJ3QRWRe5jPNpf8HCjnZz0XyJV0/4M1JvOua7IZftOttQ6KnM4m6WNIZ
 2ydg7dBhDa6iv1oKdL7wdp/rCulVWn8R7+3cRK95SnWiJ0qKDlMbIN8oGMhHdin8cSRYdmHK
 kTnvSGJNlkis5a+048o0C6jI3LozQYD/W9wq7MvgChgVQw1iEOB4u/3FXDEGulRVko6xCBU4
 SQARAQABwsFfBBgBAgAJBQJR/AoLAhsMAAoJEIredpCGysGyfvMQAIywR6jTqix6/fL0Ip8G
 jpt3uk//QNxGJE3ZkUNLX6N786vnEJvc1beCu6EwqD1ezG9fJKMl7F3SEgpYaiKEcHfoKGdh
 30B3Hsq44vOoxR6zxw2B/giADjhmWTP5tWQ9548N4VhIZMYQMQCkdqaueSL+8asp8tBNP+TJ
 PAIIANYvJaD8xA7sYUXGTzOXDh2THWSvmEWWmzok8er/u6ZKdS1YmZkUy8cfzrll/9hiGCTj
 u3qcaOM6i/m4hqtvsI1cOORMVwjJF4+IkC5ZBoeRs/xW5zIBdSUoC8L+OCyj5JETWTt40+lu
 qoqAF/AEGsNZTrwHJYu9rbHH260C0KYCNqmxDdcROUqIzJdzDKOrDmebkEVnxVeLJBIhYZUd
 t3Iq9hdjpU50TA6sQ3mZxzBdfRgg+vaj2DsJqI5Xla9QGKD+xNT6v14cZuIMZzO7w0DoojM4
 ByrabFsOQxGvE0w9Dch2BDSI2Xyk1zjPKxG1VNBQVx3flH37QDWpL2zlJikW29Ws86PHdthh
 Fm5PY8YtX576DchSP6qJC57/eAAe/9ztZdVAdesQwGb9hZHJc75B+VNm4xrh/PJO6c1THqdQ
 19WVJ+7rDx3PhVncGlbAOiiiE3NOFPJ1OQYxPKtpBUukAlOTnkKE6QcA4zckFepUkfmBV1wM
 Jg6OxFYd01z+a+oL
Message-ID: <727b9efc-f448-2955-6a47-774de330bcd8@oracle.com>
Date: Thu, 5 Apr 2018 18:33:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180405154249.33929-1-paul.durrant@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8854 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804050224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 11:42 AM, Paul Durrant wrote:
> My recent Xen patch series introduces a new HYPERVISOR_memory_op to
> support direct priv-mapping of certain guest resources (such as ioreq
> pages, used by emulators) by a tools domain, rather than having to access
> such resources via the guest P2M.
>
> This patch adds the necessary infrastructure to the privcmd driver and
> Xen MMU code to support direct resource mapping.
>
> NOTE: The adjustment in the MMU code is partially cosmetic. Xen will now
>       allow a PV tools domain to map guest pages either by GFN or MFN, thus
>       the term 'mfn' has been swapped for 'pfn' in the lower layers of the
>       remap code.
>
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
>
> v2:
>  - Fix bug when mapping multiple pages of a resource


Only a few nits below.

> ---
>  arch/x86/xen/mmu.c             |  50 +++++++++++-----
>  drivers/xen/privcmd.c          | 130 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/xen/privcmd.h     |  11 ++++
>  include/xen/interface/memory.h |  66 +++++++++++++++++++++
>  include/xen/interface/xen.h    |   7 ++-
>  include/xen/xen-ops.h          |  24 +++++++-
>  6 files changed, 270 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
> index d33e7dbe3129..8453d7be415c 100644
> --- a/arch/x86/xen/mmu.c
> +++ b/arch/x86/xen/mmu.c
> @@ -65,37 +65,42 @@ static void xen_flush_tlb_all(void)
>  #define REMAP_BATCH_SIZE 16
>  
>  struct remap_data {
> -	xen_pfn_t *mfn;
> +	xen_pfn_t *pfn;
>  	bool contiguous;
> +	bool no_translate;
>  	pgprot_t prot;
>  	struct mmu_update *mmu_update;
>  };
>  
> -static int remap_area_mfn_pte_fn(pte_t *ptep, pgtable_t token,
> +static int remap_area_pfn_pte_fn(pte_t *ptep, pgtable_t token,
>  				 unsigned long addr, void *data)
>  {
>  	struct remap_data *rmd = data;
> -	pte_t pte = pte_mkspecial(mfn_pte(*rmd->mfn, rmd->prot));
> +	pte_t pte = pte_mkspecial(mfn_pte(*rmd->pfn, rmd->prot));
>  
>  	/* If we have a contiguous range, just update the mfn itself,
>  	   else update pointer to be "next mfn". */

This probably also needs to be updated (and while at it, comment style
fixed)

>  	if (rmd->contiguous)
> -		(*rmd->mfn)++;
> +		(*rmd->pfn)++;
>  	else
> -		rmd->mfn++;
> +		rmd->pfn++;
>  
> -	rmd->mmu_update->ptr = virt_to_machine(ptep).maddr | MMU_NORMAL_PT_UPDATE;
> +	rmd->mmu_update->ptr = virt_to_machine(ptep).maddr;
> +	rmd->mmu_update->ptr |= rmd->no_translate ?
> +		MMU_PT_UPDATE_NO_TRANSLATE :
> +		MMU_NORMAL_PT_UPDATE;
>  	rmd->mmu_update->val = pte_val_ma(pte);
>  	rmd->mmu_update++;
>  
>  	return 0;
>  }
>  
> -static int do_remap_gfn(struct vm_area_struct *vma,
> +static int do_remap_pfn(struct vm_area_struct *vma,
>  			unsigned long addr,
> -			xen_pfn_t *gfn, int nr,
> +			xen_pfn_t *pfn, int nr,
>  			int *err_ptr, pgprot_t prot,
> -			unsigned domid,
> +			unsigned int domid,
> +			bool no_translate,
>  			struct page **pages)
>  {
>  	int err = 0;
> @@ -106,11 +111,12 @@ static int do_remap_gfn(struct vm_area_struct *vma,
>  
>  	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
>  
> -	rmd.mfn = gfn;
> +	rmd.pfn = pfn;
>  	rmd.prot = prot;
>  	/* We use the err_ptr to indicate if there we are doing a contiguous
>  	 * mapping or a discontigious mapping. */

Style.

>  	rmd.contiguous = !err_ptr;
> +	rmd.no_translate = no_translate;
>  
>  	while (nr) {
>  		int index = 0;
> @@ -121,7 +127,7 @@ static int do_remap_gfn(struct vm_area_struct *vma,
>  
>  		rmd.mmu_update = mmu_update;
>  		err = apply_to_page_range(vma->vm_mm, addr, range,
> -					  remap_area_mfn_pte_fn, &rmd);
> +					  remap_area_pfn_pte_fn, &rmd);
>  		if (err)
>  			goto out;
>  
> @@ -175,7 +181,8 @@ int xen_remap_domain_gfn_range(struct vm_area_struct *vma,
>  	if (xen_feature(XENFEAT_auto_translated_physmap))
>  		return -EOPNOTSUPP;
>  
> -	return do_remap_gfn(vma, addr, &gfn, nr, NULL, prot, domid, pages);
> +	return do_remap_pfn(vma, addr, &gfn, nr, NULL, prot, domid, false,
> +			    pages);
>  }
>  EXPORT_SYMBOL_GPL(xen_remap_domain_gfn_range);
>  
> @@ -183,7 +190,7 @@ int xen_remap_domain_gfn_array(struct vm_area_struct *vma,
>  			       unsigned long addr,
>  			       xen_pfn_t *gfn, int nr,
>  			       int *err_ptr, pgprot_t prot,
> -			       unsigned domid, struct page **pages)
> +			       unsigned int domid, struct page **pages)

Is this really necessary? And if it is, then why are other routines
(e.g. xen_remap_domain_gfn_range() above) not updated as well?

>  {
>  	if (xen_feature(XENFEAT_auto_translated_physmap))
>  		return xen_xlate_remap_gfn_array(vma, addr, gfn, nr, err_ptr,
> @@ -194,10 +201,25 @@ int xen_remap_domain_gfn_array(struct vm_area_struct *vma,
>  	 * cause of "wrong memory was mapped in".
>  	 */
>  	BUG_ON(err_ptr == NULL);
> -	return do_remap_gfn(vma, addr, gfn, nr, err_ptr, prot, domid, pages);
> +	return do_remap_pfn(vma, addr, gfn, nr, err_ptr, prot, domid,
> +			    false, pages);
>  }
>  EXPORT_SYMBOL_GPL(xen_remap_domain_gfn_array);
>  
> +int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
> +			       unsigned long addr,
> +			       xen_pfn_t *mfn, int nr,
> +			       int *err_ptr, pgprot_t prot,
> +			       unsigned int domid, struct page **pages)
> +{
> +	if (xen_feature(XENFEAT_auto_translated_physmap))
> +		return -EOPNOTSUPP;
> +
> +	return do_remap_pfn(vma, addr, mfn, nr, err_ptr, prot, domid,
> +			    true, pages);
> +}
> +EXPORT_SYMBOL_GPL(xen_remap_domain_mfn_array);
> +
>  /* Returns: 0 success */
>  int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
>  			       int nr, struct page **pages)
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 1c909183c42a..cca809a204ab 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -33,6 +33,7 @@
>  #include <xen/xen.h>
>  #include <xen/privcmd.h>
>  #include <xen/interface/xen.h>
> +#include <xen/interface/memory.h>
>  #include <xen/interface/hvm/dm_op.h>
>  #include <xen/features.h>
>  #include <xen/page.h>
> @@ -722,6 +723,131 @@ static long privcmd_ioctl_restrict(struct file *file, void __user *udata)
>  	return 0;
>  }
>  
> +struct remap_pfn {
> +	struct mm_struct *mm;
> +	struct page **pages;
> +	pgprot_t prot;
> +	unsigned long i;
> +};
> +
> +static int remap_pfn(pte_t *ptep, pgtable_t token, unsigned long addr,


Maybe remap_pfn_fn (to avoid name shadowing)?


> +		     void *data)
> +{
> +	struct remap_pfn *r = data;
> +	struct page *page = r->pages[r->i];
> +	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), r->prot));
> +
> +	set_pte_at(r->mm, addr, ptep, pte);
> +	r->i++;
> +
> +	return 0;
> +}
> +
> +static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
> +{
> +	struct privcmd_data *data = file->private_data;
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	struct privcmd_mmap_resource kdata;
> +	xen_pfn_t *pfns = NULL;
> +	struct xen_mem_acquire_resource xdata;
> +	int rc;
> +
> +	if (copy_from_user(&kdata, udata, sizeof(kdata)))
> +		return -EFAULT;
> +
> +	/* If restriction is in place, check the domid matches */
> +	if (data->domid != DOMID_INVALID && data->domid != kdata.dom)
> +		return -EPERM;
> +
> +	down_write(&mm->mmap_sem);
> +
> +	vma = find_vma(mm, kdata.addr);
> +	if (!vma || vma->vm_ops != &privcmd_vm_ops) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	pfns = kcalloc(kdata.num, sizeof(*pfns), GFP_KERNEL);
> +	if (!pfns) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (xen_feature(XENFEAT_auto_translated_physmap)) {
> +		struct page **pages;
> +		unsigned int i;
> +
> +		rc = alloc_empty_pages(vma, kdata.num);
> +		if (rc < 0)
> +			goto out;
> +
> +		pages = vma->vm_private_data;
> +		for (i = 0; i < kdata.num; i++) {
> +			pfns[i] = page_to_pfn(pages[i]);
> +			pr_info("pfn[%u] = %p\n", i, (void *)pfns[i]);
> +		}
> +	} else
> +		vma->vm_private_data = PRIV_VMA_LOCKED;
> +
> +	memset(&xdata, 0, sizeof(xdata));
> +	xdata.domid = kdata.dom;
> +	xdata.type = kdata.type;
> +	xdata.id = kdata.id;
> +	xdata.frame = kdata.idx;
> +	xdata.nr_frames = kdata.num;
> +	set_xen_guest_handle(xdata.frame_list, pfns);
> +
> +	xen_preemptible_hcall_begin();
> +	rc = HYPERVISOR_memory_op(XENMEM_acquire_resource, &xdata);
> +	xen_preemptible_hcall_end();
> +
> +	if (rc)
> +		goto out;
> +
> +	if (xen_feature(XENFEAT_auto_translated_physmap)) {
> +		struct remap_pfn r = {
> +			.mm = vma->vm_mm,
> +			.pages = vma->vm_private_data,
> +			.prot = vma->vm_page_prot,
> +		};
> +
> +		rc = apply_to_page_range(r.mm, kdata.addr,
> +					 kdata.num << PAGE_SHIFT,
> +					 remap_pfn, &r);
> +	} else {
> +		unsigned int domid =
> +			(xdata.flags & XENMEM_rsrc_acq_caller_owned) ?
> +			DOMID_SELF : kdata.dom;
> +		int num;
> +
> +		num = xen_remap_domain_mfn_array(vma,
> +						 kdata.addr & PAGE_MASK,
> +						 pfns, kdata.num, (int *)pfns,
> +						 vma->vm_page_prot,
> +						 domid,
> +						 vma->vm_private_data);
> +		if (num < 0)
> +			rc = num;
> +		else if (num != kdata.num) {
> +			unsigned int i;
> +
> +			for (i = 0; i < num; i++) {
> +				rc = pfns[i];
> +				if (rc < 0)
> +					break;
> +			}
> +		} else
> +			rc = 0;
> +	}
> +
> +out:
> +	kfree(pfns);
> +
> +	up_write(&mm->mmap_sem);

I'd swap these two.


-boris
