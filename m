Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935338AbeEXA4o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 20:56:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935196AbeEXA4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 20:56:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 24 May 2018 08:56:37 +0800
From: cang@codeaurora.org
To: Rob Herring <robh@kernel.org>
Cc: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/3] dt-bindings: phy-qcom-qmp: Add UFS phy compatible
 string for sdm845
In-Reply-To: <20180523161323.GA28074@rob-hp-laptop>
References: <20180523034712.3420-1-cang@codeaurora.org>
 <20180523034712.3420-4-cang@codeaurora.org>
 <20180523161323.GA28074@rob-hp-laptop>
Message-ID: <10338ae800fa862d23e5e7c64cffc119@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-24 00:13, Rob Herring wrote:
> On Wed, May 23, 2018 at 11:47:12AM +0800, Can Guo wrote:
>> Update the compatible string for UFS QMP PHY on SDM845.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you Rob.
