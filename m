Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751065AbeC0HSI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:18:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34898 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeC0HSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:18:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Mar 2018 15:18:05 +0800
From: cang@codeaurora.org
To: Rob Herring <robh@kernel.org>
Cc: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: phy-qcom-qmp: Add UFS phy compitable
 string for sdm845
In-Reply-To: <20180326061514.3rgc5ucww5gwqboi@rob-hp-laptop>
References: <20180321053720.12780-1-cang@codeaurora.org>
 <20180321053720.12780-3-cang@codeaurora.org>
 <20180326061514.3rgc5ucww5gwqboi@rob-hp-laptop>
Message-ID: <e11d25826fd4eadba4a00766119e5bc4@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-27 06:24, Rob Herring wrote:
> On Wed, Mar 21, 2018 at 01:37:20PM +0800, Can Guo wrote:
>> Update the compatible string for UFS QMP PHY on SDM845.
> 
> typo in the subject.
> 

Thank you Rob, shall correct it in the next patch series.

Thanks
Can.

>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
