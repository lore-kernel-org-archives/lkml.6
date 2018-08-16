Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3764C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94C92147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94C92147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeHQAPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:15:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725864AbeHQAPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:15:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7GL9Lkq041640
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 17:14:49 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kwgpjrpg2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 17:14:49 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 15:14:48 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Aug 2018 15:14:46 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7GLEjOc61145096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Aug 2018 14:14:45 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6434B136053;
        Thu, 16 Aug 2018 15:14:45 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FB9613605D;
        Thu, 16 Aug 2018 15:14:39 -0600 (MDT)
Received: from oc6728276242.ibm.com (unknown [9.80.207.203])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Aug 2018 15:14:39 -0600 (MDT)
Subject: Re: [RFC 1/2] dt-bindings: media: Add Aspeed Video Engine binding
 documentation
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, robh@kernel.org
References: <1534448601-74120-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1534448601-74120-2-git-send-email-eajames@linux.vnet.ibm.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Thu, 16 Aug 2018 16:14:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534448601-74120-2-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081621-0016-0000-0000-0000091BC9CA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009557; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01074510; UDB=6.00553739; IPR=6.00854468;
 MB=3.00022764; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-16 21:14:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081621-0017-0000-0000-00004005D3A0
Message-Id: <0072215a-9249-2ad3-3d66-2f1b605ad915@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808160216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/16/2018 02:43 PM, Eddie James wrote:
> Document the bindings.
>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>   .../devicetree/bindings/media/aspeed-video.txt     | 25 ++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
>
> diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
> new file mode 100644
> index 0000000..91a494e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/aspeed-video.txt
> @@ -0,0 +1,25 @@
> +* Device tree bindings for Aspeed Video Engine
> +
> +The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs can
> +capture and compress video data from digital or analog sources.
> +
> +Required properties:
> + - compatible:		"aspeed,ast2400-video" or "aspeed,ast2500-video"
> + - reg:			contains the offset and length of the VE memory region
> + - clocks:		pointers to the the "vclk" and "eclk" of the syscon
> + - clock-names:		"vclk-gate", "eclk-gate"
> + - resets:		pointer to the VE reset of the syscon
> + - interrupts:		the interrupt associated with the VE on this platform
> + - reg-scu:		pointer to the syscon itself

Forgot to remove syscon reference in latest, it's not needed.

Thanks,
Eddie

> +
> +Example:
> +
> +video: video@1e700000 {
> +        compatible = "aspeed,ast2500-video";
> +        reg = <0x1e700000 0x20000>;
> +        clocks = <&syscon ASPEED_CLK_GATE_VCLK>, <&syscon ASPEED_CLK_GATE_ECLK>;
> +        clock-names = "vclk-gate", "eclk-gate";
> +        resets = <&syscon ASPEED_RESET_VIDEO>;
> +        interrupts = <7>;
> +        reg-scu = <&syscon>;
> +};

