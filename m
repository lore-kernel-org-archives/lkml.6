Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437A5C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D6F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D6F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeICTWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:22:19 -0400
Received: from smtp113.iad3a.emailsrvr.com ([173.203.187.113]:34545 "EHLO
        smtp113.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbeICTWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:22:19 -0400
Received: from smtp39.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp39.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 1C0B95852;
        Mon,  3 Sep 2018 10:52:23 -0400 (EDT)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id 9038258E5;
        Mon,  3 Sep 2018 10:52:22 -0400 (EDT)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 03 Sep 2018 10:52:23 -0400
Subject: Re: [PATCH 1/4] staging: comedi: Correct multiline dereference as per
 TODO
From:   Ian Abbott <abbotti@mev.co.uk>
To:     Ray Clinton <mr.ray.clinton@gmail.com>, greg@kroah.com
Cc:     hsweeten@visionengravers.com, linux-kernel@vger.kernel.org
References: <CAPMnawvndQUGj4ohrTCPrwcvZdS-3FrHGsNeN4N7OJ_YGK-QfQ@mail.gmail.com>
 <a7eeb3a5-ba6a-14c4-8ed4-7aa29d3840ce@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <4b023c3d-eaeb-6466-5bc8-caed57fbd48b@mev.co.uk>
Date:   Mon, 3 Sep 2018 15:52:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a7eeb3a5-ba6a-14c4-8ed4-7aa29d3840ce@mev.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/18 15:47, Ian Abbott wrote:
> On 30/08/18 18:32, Ray Clinton wrote:
>> Using checkpatch.pl I was able to find a multiline dereference which goes
>> again the coding style for the kernel. I'm still working on my email 
>> client so
>> the indentation looks bad here (in gmail) but the arguments for
>> comedi_check_trigger_arg_min should go just under the opening (
> 
> The patch description should describe what the patch does, not how bad 
> the indentation loos in your email client.

"loos" ==> "looks"

Also, you sent 4 patches with the same subject line (other than the 
PATCH 1/4 part).  They should be different.  You can include the driver 
name in the patch subject line to distinguish them, e.g.:

staging: comedi: dt3000: Correct multiline dereference

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
