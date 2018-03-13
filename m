Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933325AbeCMLyy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:54:54 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:32443 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933133AbeCMLyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:54:50 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180313115448epoutp04acccc9261580792a72ce44e499948c90~beMVulben1469714697epoutp04F
X-AuditID: b6c32a47-187ff7000000100c-79-5aa7bc077dfc
Subject: Re: [RFC 1/2] pci: dwc: pci-exynos: modify the Kconfig dependency
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzk@kernel.org, jingoohan1@gmail.com,
        kgene@kernel.org
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <39521cb5-07a5-24b5-b545-a01c730f1985@samsung.com>
Date: Tue, 13 Mar 2018 20:54:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.5.0
MIME-version: 1.0
In-reply-to: <20180313111211.GA15480@e107981-ln.cambridge.arm.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTVJd9z/Iog8+zzS3mHznHarHiy0x2
        i/7Hr5ktzp/fwG5xedccNouz846zWcw4v4/J4s3vF+wWrXuPsDtweqyZt4bRY+esu+wem1Z1
        snl83iQXwBKVapORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp2tDQSM/QwFzPyMhIz8Q41srIFKgk
        ITWjd2FuQS9XxdOpC9kbGLs4uhg5OSQETCSOt05k7GLk4hAS2MEocb7hBRuE851R4uXCX0ww
        VZfv72OFSGxglLg4YTMzhHOXUaL//2qwKmEBL4nO2QfZQWwRAUOJnlMgcS4OZoHTjBJnHrwE
        S7AJ6Ehs/3YcrIFXwE7iys+VYHEWAVWJ3fdOM4LYogJhEkdnfmKEqBGU+DH5HguIzSngJNG9
        ey8biM0soCnx4sskFghbXKK59SaULS+xec1bsOskBO6zSXzuP88O8YOLxJXmeVC2sMSr41ug
        bGmJZ6s2MkLY7YwSZ2cLQzRPYZRYMaMbGgDGEs8WdjFBbOCT6Dj8F6iZAyjOK9HRJgRR4iFx
        ZONjqJmOEg+er2OBBNFxRolLbfdZJzDKzULy0CwkT8xC8sQsJE8sYGRZxSiWWlCcm55abFRg
        rFecmFtcmpeul5yfu4kRnBi13Hcwbjvnc4hRgINRiYfXoHlZlBBrYllxZe4hRgkOZiURXrOe
        5VFCvCmJlVWpRfnxRaU5qcWHGE2BAT6RWUo0OR+YtPNK4g1NLA1MzMyMzM0sgOlNnLc1wCVK
        SCA9sSQ1OzW1ILUIpo+Jg1OqgbH6bGqtgavWj/+CJ5fPqdq1ZdG3HHEzUYHURVxnbjgdSlig
        ZB/08dHkXVPMzgtUb/lw/z/H5LdPeb4vWvugwS25NebE2rXlLlm7jXr6RQ74TyzZtW7Rq98a
        6xyv/JY57HZoq/8Do2OvJxRWrkta5uYf0GsfN5drjvhltcNCJ51/pN1dJv2Bb52eEktxRqKh
        FnNRcSIAfLkXoKIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsVy+t9jQV32PcujDO63M1vMP3KO1WLFl5ns
        Fv2PXzNbnD+/gd3i8q45bBZn5x1ns5hxfh+TxZvfL9gtWvceYXfg9Fgzbw2jx85Zd9k9Nq3q
        ZPP4vEkugCWKyyYlNSezLLVI3y6BK6N3YW5BL1fF06kL2RsYuzi6GDk5JARMJC7f38faxcjF
        ISSwjlHi6oF2ZgjnPqPElBmdbCBVwgJeEp2zD7KD2CIChhI9p1YzgRQxC5xmlHjybDsrSEJI
        4CSjREeLHYjNJqAjsf3bcSYQm1fATuLKz5VgzSwCqhK7751mBLFFBcIkejZdZoSoEZT4Mfke
        C4jNKeAk0b17L9BiDqAF6hJTpuSChJkFxCWaW2+yQNjyEpvXvGWewCgwC0n3LISOWUg6ZiHp
        WMDIsopRMrWgODc9t9iowCgvtVyvODG3uDQvXS85P3cTIzAath3W6t/B+HhJ/CFGAQ5GJR7e
        jtZlUUKsiWXFlbmHGCU4mJVEeM16lkcJ8aYkVlalFuXHF5XmpBYfYpTmYFES5+XPPxYpJJCe
        WJKanZpakFoEk2Xi4JRqYPSbp3n10zOZjQmuqbfOX1byuXRvTq2YW+BG3wNTpVS+zfK5HpBf
        G/PXhM9AbeLTtbGii65sMr7i0mAs+HjOlfk6xjV/DNeJXV3XlfJo305GVaElMYatyTeiO7Qm
        7JwiI9pg2fsp6u0EnuU7E6+FM/KInbpcfvpGepMYR+7zrKvFl8s7Zsnuk1RiKc5INNRiLipO
        BABIcZpFggIAAA==
X-CMS-MailID: 20180313115447epcas2p3110ae14ff7c81ca2e29ea9f85c03b503
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20171221121409epcas1p2af291857b9df115d2dec9a3d3300e0aa
X-RootMTR: 20171221121409epcas1p2af291857b9df115d2dec9a3d3300e0aa
References: <CGME20171221121409epcas1p2af291857b9df115d2dec9a3d3300e0aa@epcas1p2.samsung.com>
        <20171221121408.22636-1-jh80.chung@samsung.com>
        <20180313111211.GA15480@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Lorenzo,

On 03/13/2018 08:12 PM, Lorenzo Pieralisi wrote:
> Hi Jaehoon,
> 
> On Thu, Dec 21, 2017 at 09:14:06PM +0900, Jaehoon Chung wrote:
>> PCI_EXYNOS has the dependency with SOC_EXYNOS5440.
>> It's modified to ARCH_EXYNOS from SOC_EXYNOS5440, because other
>> SoCs needs to use this driver.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/pci/dwc/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
>> index 113e09440f85..0ff9795df8e8 100644
>> --- a/drivers/pci/dwc/Kconfig
>> +++ b/drivers/pci/dwc/Kconfig
>> @@ -65,7 +65,7 @@ config PCIE_DW_PLAT
>>  config PCI_EXYNOS
>>  	bool "Samsung Exynos PCIe controller"
>>  	depends on PCI
>> -	depends on SOC_EXYNOS5440
>> +	depends on ARCH_EXYNOS
>>  	depends on PCI_MSI_IRQ_DOMAIN
>>  	select PCIEPORTBUS
>>  	select PCIE_DW_HOST
> 
> This patch fell through the cracks, is it still needed ? Please let
> me know and I will apply it if it is, thank you very much.

I will resend the patches for supporting exynos5433(TM2 board) without RFC.
I have already prepared the patches. now i'm doing some more test and cleaning code.

Best Regards,
Jaehoon Chung

> 
> Lorenzo
> 
> 
> 
