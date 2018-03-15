Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeCOBkF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:40:05 -0400
Received: from mail-cys01nam02on0129.outbound.protection.outlook.com ([104.47.37.129]:54963
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750950AbeCOBkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:40:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zi.yan@cs.rutgers.edu;
From: "Zi Yan" <zi.yan@cs.rutgers.edu>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Michal Hocko" <mhocko@suse.com>, "Minchan Kim" <minchan@kernel.org>,
        "Shaohua Li" <shli@kernel.org>, jglisse@redhat.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -mm] mm, madvise, THP: Use THP aligned address in
 madvise_free_huge_pmd()
Date: Wed, 14 Mar 2018 21:39:54 -0400
X-Mailer: MailMate (1.11r5462)
Message-ID: <869F4AAA-5BBA-40D6-916F-6919E515D271@cs.rutgers.edu>
In-Reply-To: <20180315011840.27599-1-ying.huang@intel.com>
References: <20180315011840.27599-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_D918F561-2FC7-4795-8EA5-369E1EC9958A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [173.63.110.204]
X-ClientProxiedBy: CY4PR1601CA0027.namprd16.prod.outlook.com
 (2603:10b6:910:72::40) To CY4PR14MB1733.namprd14.prod.outlook.com
 (2603:10b6:903:15b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 100fd9f9-0c88-4d9c-6e22-08d58a15aa4f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR14MB1733;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR14MB1733;3:2VzYWpsz2jd1Ul2WVMLiJ2y6Tao7OWjKsZKyjnEPtnMlRUUmx8eCgi91QJ4zIyxi1XeBllQWnglDn4pvRWylZxBjJ4L7jR0pR7y8QUVz0mrmWXFX1n2UZVHZpMTlJDv7MjXOM0d+paFFiy2jjhGo4rSDeFUQReM3qHCVvu6FUVqINToSExObqs1+Ll6lBj2tXW4F2TQ4Uz5XL36B1bKeLLmOWerpgmL0JFyyAhmCYyqfp2BwQLtXQqlndj8lzJ3R;25:FzVILY/TYnuSz1GJQNCscITmdZJr9LnHzRukz5J5GdWThGOBE3FFHGrwp3/Y0Y/o2ezg56GKvBgbarOWR3dqVQ262GF+LVDJVlPSXMUbv+xoE9nNwLVbKGu2Lobukrvtsv7Se8++lKi4ESjL9w2QZKvtrpOyNeMBKPORZltQBUcGvSxUOXT0sC3/sdm6q8A6wrwtiAJv8y5l+tfcLCYWx5emftpBuGQxCFUSr7PfIzuu/E6RCGIAhYPVre6DMM3Q4TwhmlSil51XehxygvneVTn3NmGpMmAl3Oh7DK7a+xUWKs7k3inAUjyFewAqkcLa5hHphdJUPUhJVheIi1AFXg==;31:BXnEILfLnRRkNT7dBVyWAfCmAqIE1B+IjPY/ZX7SdMXoLzCGLLnN43R5Bk5iYIpaZbCimVIvfNfG+NpX+xy/s+NjOjW8OfOgCDxEF/p0EGpqN9vkMniuZ0ma6ED8pOGUxfB14t7te2d/T+bNSjzGxjdHKFTrllNyWfHxQdTWP/ZLv0CRwgeZrtdSrsDu9q3FufHKOxzNF32zFXXlGMiYAoIvOZ6VH/wBWeEqmiBmcJE=
X-MS-TrafficTypeDiagnostic: CY4PR14MB1733:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR14MB1733;20:w1nha5FAoZl5Fr/Ay1Qypgu+9FlL8JApSVXj3UBdnQD1glJhNzu5wScIqExEK9CqUQ1nOTlzjIupB/c/gR1p9WX/662IuuE37bkluPsvmGKB0vs4aJSZV2DKNsR2gfldH8GyAtVrHRqqL1AyMh62rZTNm3YjSaqx5tbExTnGevraghFOXrrC+3EpkTOoR3uD5sfSS6iUsr26t85EPl7Xe//d8M9zn1bvOF3aESyNJ0+m3mw4rqD9Kg9ayByQA+Dq4BiLsr9fnHR3FnWYIIXVDqTf5Drq9+GZk1fc6/TPxHtolecXSRObqcpbb9MqubjHvwd0aXoKjGVgMgBpBqnpBKc8u6fZFD686VDEsFK3g3voDIIrl2eamYEdyzZBkteLzg/nu6r8Vx41KA6qTChyYXz4oo9O2YI5T8UwVsr+JDKwpF5hESZNCGc4pLS0m14U6SpDrhUR6hx87SBxSTZ+EGDbmzSvLejo/ZCBSgPOGajnUQhS71RnWl8WkgegoZhA;4:YbMgw9nP+DHFOoYopj+qqj+V7BoItgtyvLEhVzJUpW2ugFYgfT5sUfCfYjoBvOmDWYTDby8YRNAm5CGFxNq5wiTxqkvAZjA9g/OwHLpFAkSq6DfxXfsEBT4DRPwF2O0GXqW9pAcOYv2sgNeMyJvi+VUf4rUTe8Way8Y6K8Nx6z6j4HGSxUSuXjSXqZUlqDM+cUy5y8Qi2fxHxhO0G68R2KRclJiI6t0DK+M/AmLEozpbNs75j5ChRIzUchIzrSjukvnTnyMtv34J7CIilWWG0L8SLQRB/uJ2o95CJkGLEI5oeTpRgu2gn+HloC0IDajl1TgkXO/MWsn+vZrCHq3RRwX2XoNjHOsuaNYT5VT8zCM=
X-Microsoft-Antispam-PRVS: <CY4PR14MB1733DF772B118BF632B3044CA5D00@CY4PR14MB1733.namprd14.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(11241501184)(944501244)(52105095)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR14MB1733;BCL:0;PCL:0;RULEID:;SRVR:CY4PR14MB1733;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39860400002)(39380400002)(346002)(396003)(199004)(189003)(68736007)(81156014)(53546011)(33964004)(4326008)(16526019)(16576012)(86362001)(2950100002)(50226002)(6916009)(77096007)(386003)(786003)(229853002)(6486002)(54906003)(52116002)(105586002)(84326002)(186003)(76176011)(83716003)(316002)(53936002)(81166006)(6666003)(26005)(106356001)(6116002)(25786009)(5660300001)(16586007)(33656002)(7416002)(6246003)(3846002)(97736004)(5890100001)(478600001)(568964002)(2906002)(8676002)(8936002)(75432002)(66066001)(88552002)(305945005)(82746002)(7736002)(14583001)(72826003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR14MB1733;H:[172.16.126.1];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjE0TUIxNzMzOzIzOjNpT0JBYWhNaTZxUUlmem5vdXZQRlU2SlFk?=
 =?utf-8?B?bXIySkpTZTUzUExtSm0wdTZiamI2L2ZGcWhMeVkxQ1ZSS1NLQUphY3ZQZ0Yz?=
 =?utf-8?B?UWFkSzI4T01NMkFqUDM5NVlOL3JleW5pNWVGQ1p5REVwREZ4MiszUlh1TzMw?=
 =?utf-8?B?SmpjUm1pdW9zWTdrcFRwQ09icUdTUEZiQnVRUWRjc0ZqRER1REZsaVdKcVJi?=
 =?utf-8?B?SUJQNENBY2hvSXErcGNGVWVMdWxFQjFDZUU0a2FnbFdqSmU3ZmY1aGlZYWo1?=
 =?utf-8?B?aDRuQmVKWHZJV29WcW05Q241cWMyMlVFenduR3QwazMxY1p2K1N3N3JxTk4r?=
 =?utf-8?B?T242MldoZTdqU0R5T1p0cWVZR0hFc2dMNGY0MmlCakZXK2UrTE0ydEpmSVov?=
 =?utf-8?B?YmRnaHdvWnF3T2dlaWxIaXFydkVyS0JyNlhvYXdRYitSaVIzcUNGY0NHS3R2?=
 =?utf-8?B?Yno2dDVsRExsNFpMTk9GTUlTR21LRlpWcS8yU2Z1OVVNL2M2TkNhdHRZMUF3?=
 =?utf-8?B?QUtjUHFZNzV6eTUvR2YxM0hUNzRmSmh2alhnNk0zV1prREZQT2g2OW8wQkFj?=
 =?utf-8?B?TS9FajhSU3Roc0x2aDQwNVE0WStXYWNLdUFVRmlteW1mSnUxTlRFL282SkNk?=
 =?utf-8?B?bEtDNkdXZWZXTnFrQUtxM3g1V0lYUWJ0aFVHZ2tCU0d2cnZHUk9YaUphOEoz?=
 =?utf-8?B?L2E0ck04bmlpV3VqRlcrejRLQlp6ZU9jM0QxRHZZblZjNkxWaWppUm1FSVNs?=
 =?utf-8?B?R2dBQzZzVDhaL0VucnhvQVdvQUw0SThGUFNQR2w0bHVJN25ad1dreTE4U2tq?=
 =?utf-8?B?ZWQwWHZ4cXB4NzdwMDNheVZxUDVYdkkzcGNncXpnWnZuMThFeTNNb05lVFEw?=
 =?utf-8?B?Z00vWGVBNExKNGRzWUt3RWx6eHpham0yWEVGYlFGZDFmT2ZsUUJ1Q1A2VmhC?=
 =?utf-8?B?dFNiL3VvUjRxU01KM3V0MllYalhjSkd4dTdlS1JxQ0plOUZ5aVo2QzU3YVl6?=
 =?utf-8?B?Ty9xcXVzYXVPRjR6ekR4bnUxZGhIbXFYYkRabkg0SUFKMkROTkZmbEwxYzc5?=
 =?utf-8?B?M3owYnRsMEFRU2Fidit1elBYYmEvZFRzOUIrVCtlbTFvL3RnSEpZdGxaeXE5?=
 =?utf-8?B?T0hJbDd2cUF0a0RGTnVTaHQwOHJ6R1JiQXFCMkd5N28waVEybmxXdWp5a3Fl?=
 =?utf-8?B?b1JhdWFKeE5hakp4QVI3Z1ppbExPUmpMN2M4Ulplb1VNczdTSHhaaTR0N2d2?=
 =?utf-8?B?MjROVGk2VW9PbHVhNnZrdDk5bkJCeitnZmc3SVdxSFhueE1pRGZ6aDU1OU5o?=
 =?utf-8?B?bTA2SE9JZDZjZ0lWV1pEWU1LNisyYkU3T21uNmtmSTNkOUpZS2ZCalhHNGh0?=
 =?utf-8?B?dkNnanZLYVBxM0NCblQwc3AyMHI4Tzh2bmxJampsY3BKaVBSTjA5ZWJtNm85?=
 =?utf-8?B?U3JLUkRNOUh4cG9jdWNtMTIrZ2ZreG5KZndCdyt5QW94STBFd2tlSHVPdTJs?=
 =?utf-8?B?UytoaFNkMmRLL0RYUmMxWkVNWGM2NlVqSG95U2Q5MlFEaTJXaS9vUGcvbzlQ?=
 =?utf-8?B?RkR2VVRONXJFak5ML25JS0pvS3RULzdFY1lBSUFPUENkeWFLQ0VQcUgyZG5G?=
 =?utf-8?B?MTQ3WHRNTzBSUWVaVmhtTmZySWVNZVdzZUs5ekNvWG1ua3BCZ0IyYXlOaFdx?=
 =?utf-8?B?NGxQYldWSkVqSXNSc2QxVW1zKzRLYnp3KzQrUWNUN01yYjVtTFd2OFdaZ1Zj?=
 =?utf-8?B?cHZJSGpSQ1YxbFdlUnAwQVhzQUZOYWlUb1NxU1dhc2trNUpPU3FvSXlieUEw?=
 =?utf-8?B?OHdyaS9nRzlIVUZuTHJSaTl4bzZESWo5T0F0OWVvQXM5SGNzSVpWY0QzNFMv?=
 =?utf-8?Q?1/JxUf6rXB0=3D?=
X-Microsoft-Antispam-Message-Info: fkz+JkT8I6rS1J05HFFvpCPccDaWEm5XyrJWhPoy+sn5isvtOIsXOdvDOAUnVXwAQF3HQPhz5tHIDZfkZps6wixOR4DrCH4QO+WxYP1dvq82vHLMZi/8w6nwOH16Zgbko2OHL5bdGtCO7WR8FRzX7N2X3AyFAcNFJPCHbcXjpn9Ed4d2fQlL7KwrcgE0jgLP
X-Microsoft-Exchange-Diagnostics: 1;CY4PR14MB1733;6:N9ngISlLMsfM3xQQlcLcyyZ2Cff+sE0gHNJCWQ5ZQDLMKnLhjQi4vNw1ugdAyJnvYjp1vJ6lzg/BufalABgmSVsV2VuzMvOuY8XUbgyA564kA1DI0c1lkFno5E5Gp0+LMYNtH6z05InXDodOgHdLlzYtOuDnmhtQxi8XkHiDhvEp8EJF1NAoXLk7TiWdsAbOe7zA2sOOHk1MZwxcO1UXTiL0rqWRSQfgqVmjcCVT/2B/SemDEtEMug1iB47jy845zP4oIaLc9VWyJJp9uFlff7zGHYzvyJtKnXmN0ApfZh8MWSc8OymebgJeDsOXdOB8I3YQG34zHtUfHqwvATOO+bxjBirLOPAakmiVaQnMDpQ=;5:WWs1fgrIn7cEw9Do0tpB4DDotsDdRbY2Zlj+SZrWlzNJcvItjLI7dfGJWFo7+0SwVVsPeksyj5+ytDs+C97FEq9qg3nE9pP73h5ZdTec0H47q52vhBRk/dcfOxLEb/r/dybBqbVPti7fnO2CzijI7D/RVn9YoX3hXGUPNR/jgC0=;24:qy4Wm6tX12XQoKU/WnfoggvFolmZDf6GwJolCrCh34Bdp0lwby7CK84+jVTf2ltyHm0PM5AceNTdK/etr3j/kQddZAvjUXBqGSnCIza1FkM=;7:Wu1TVPIYDcPona6UAgyk/CX4NjZpWzLSAbehQuOowVhOfdDKknewnncNqR1ksNOc3IJ/+Mpj83V9EUL6ZY4Qn3js/ExcWV3Gya6DGEOVIMx8xQvY/W1Z06p7+vmSTFUW/aKyZIXt/BfUHiSMFnk+sb42d89Y4mYys8C5CP6P51EsTyPx5Ijwz59TgwFwD9PH05dqu3VPiL/Z72fN8Yk5LNOkEJ7EGO7wF8xb/zqIow8WouGtULf9D0BcLziwk2tK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cs.rutgers.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 01:39:59.0165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 100fd9f9-0c88-4d9c-6e22-08d58a15aa4f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR14MB1733
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_D918F561-2FC7-4795-8EA5-369E1EC9958A_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This cannot happen.

Two address parameters are passed: addr and next.
If =E2=80=9Caddr=E2=80=9D is not aligned and =E2=80=9Cnext=E2=80=9D is al=
igned or the end of madvise range, which might not be aligned,
either way next - addr < HPAGE_PMD_SIZE.

This means the code in =E2=80=9Cif (next - addr !=3D HPAGE_PMD_SIZE)=E2=80=
=9D, which is above your second hunk,
will split the THP between =E2=80=9Caddr=E2=80=9D and =E2=80=9Cnext=E2=80=
=9D and get out as long as =E2=80=9Caddr=E2=80=9C is not aligned.
Thus, the code in your second hunk should always get aligned =E2=80=9Cadd=
r=E2=80=9D.

Let me know if I miss anything.

=E2=80=94
Best Regards,
Yan Zi

On 14 Mar 2018, at 21:18, Huang, Ying wrote:

> From: Huang Ying <ying.huang@intel.com>
>
> The address argument passed in madvise_free_huge_pmd() may be not THP
> aligned.  But some THP operations like pmdp_invalidate(),
> set_pmd_at(), and tlb_remove_pmd_tlb_entry() need the address to be
> THP aligned.  Fix this via using THP aligned address for these
> functions in madvise_free_huge_pmd().
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> Cc: jglisse@redhat.com
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  mm/huge_memory.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0cc62405de9c..c5e1bfb08bd7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1617,6 +1617,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb=
, struct vm_area_struct *vma,
>  	struct page *page;
>  	struct mm_struct *mm =3D tlb->mm;
>  	bool ret =3D false;
> +	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
>
>  	tlb_remove_check_page_size_change(tlb, HPAGE_PMD_SIZE);
>
> @@ -1663,12 +1664,12 @@ bool madvise_free_huge_pmd(struct mmu_gather *t=
lb, struct vm_area_struct *vma,
>  	unlock_page(page);
>
>  	if (pmd_young(orig_pmd) || pmd_dirty(orig_pmd)) {
> -		pmdp_invalidate(vma, addr, pmd);
> +		pmdp_invalidate(vma, haddr, pmd);
>  		orig_pmd =3D pmd_mkold(orig_pmd);
>  		orig_pmd =3D pmd_mkclean(orig_pmd);
>
> -		set_pmd_at(mm, addr, pmd, orig_pmd);
> -		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> +		set_pmd_at(mm, haddr, pmd, orig_pmd);
> +		tlb_remove_pmd_tlb_entry(tlb, pmd, haddr);
>  	}
>
>  	mark_page_lazyfree(page);
> -- =

> 2.16.1

--=_MailMate_D918F561-2FC7-4795-8EA5-369E1EC9958A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQFKBAEBCgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAlqpzuoWHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzJ7XB/9zWV2AhzeiHiU7rDo4Zz1oa5/J
Bezggv7XS03LbSeHrYHaSo0NufxvGoE3gADqUQrMDrfq8LkYc7a6iua9IXBHOzrh
kU+tXVuhmPKbUKplXfXc1oeSVoi/4qHcdgcUiYYMKX6GNCsJzm6FgxB+xNvxrAq+
2b4hYoXO02eFaTlOgEgwu27IDH07P0PhEzEXTsXEoNi87TDPoc1xeoybz/ATOI09
L4SFXg6XlpkHQR9wt4cf3zSqdj8wyXU5sdUJa0C4+SmfNq3nz1ek452G3PNPbxCA
KfjWQbzbzdw5qnFD/tPxk/coQ6mRKeRPyAs5t8R0VyJtAMLRqeVQreRgqZUF
=IQbt
-----END PGP SIGNATURE-----

--=_MailMate_D918F561-2FC7-4795-8EA5-369E1EC9958A_=--
