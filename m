Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeDPIit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:38:49 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:59908 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbeDPIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:38:47 -0400
Subject: Re: [PATCH v3 01/10] bindings: PCI: designware: Example update
To: Rob Herring <robh@kernel.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
 <a3eebc66b17172b92e91d95c12a9d0289b9417c2.1523360166.git.gustavo.pimentel@synopsys.com>
 <20180413213427.3ny7ids3q7yxf35g@rob-hp-laptop>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <452a9fc7-872d-05d4-289c-84ec58c0bee9@synopsys.com>
Date: Mon, 16 Apr 2018 09:37:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413213427.3ny7ids3q7yxf35g@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 13/04/2018 22:34, Rob Herring wrote:
> On Tue, Apr 10, 2018 at 01:58:33PM +0100, Gustavo Pimentel wrote:
>> Replaces "ctrlreg" reg-name by "dbi" to be coherent with similar drivers,
>> however it still be compatible with any previous DT that uses the old
>> reg-name.
>>
>> Replaces the PCIe base address example by a real PCIe base address in use.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Changes v1->v2:
>>  - Removed any iATU reference or changes to avoid confusion.
>>  - Add "snps,dw-pcie" compatible string following Kishon's suggestion.
>> Changes v2->v3:
>> - Nothing changed, just to follow the patch set version.
>>
>>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index 1da7ade..f02cd20 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -1,7 +1,8 @@
>>  * Synopsys DesignWare PCIe interface
>>  
>>  Required properties:
>> -- compatible: should contain "snps,dw-pcie" to identify the core.
>> +- compatible:
>> +	"snps,dw-pcie-rc", "snps,dw-pcie" for RC mode;
> 
> I think adding this compatible is pointless. "snps,dw-pcie" meant RC and 
> should continue to mean that. We also have compatibles with the IP 
> version number as well as the SoC specific compatible strings. We don't 
> need 4 compatible strings here.

Ok.

> 
> Rob
> 

Thanks,
Gustavo
