Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4121EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7411208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7411208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeGMUdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:33:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:59630 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbeGMUdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:33:41 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fe4VM-0001OB-1i; Fri, 13 Jul 2018 22:17:28 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fe4VL-00063E-Sm; Fri, 13 Jul 2018 22:17:27 +0200
Subject: Re: [PATCH] scripts/tags.sh: Add BPF_CALL
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Constantine Shulyupin <const@MakeLinux.com>
Cc:     ast@kernel.org, netdev@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180712052850.28396-1-const@MakeLinux.com>
 <20180713181001.2ugugmnmldyrq7li@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4122ba41-7cdd-13c8-f8ef-0ea6f6abd6dc@iogearbox.net>
Date:   Fri, 13 Jul 2018 22:17:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180713181001.2ugugmnmldyrq7li@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24749/Fri Jul 13 14:56:11 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 08:10 PM, Alexei Starovoitov wrote:
> On Thu, Jul 12, 2018 at 08:28:46AM +0300, Constantine Shulyupin wrote:
>> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> 
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
