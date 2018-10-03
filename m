Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB04EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5EE20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5EE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJCTlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:41:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:2863 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbeJCTlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:41:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 05:52:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="96099048"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2018 05:52:39 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUEUED v20180920 00/16] stm class/intel_th: Queued updates for v4.20
In-Reply-To: <20180927171844.GE7481@xps15>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com> <20180927171844.GE7481@xps15>
Date:   Wed, 03 Oct 2018 15:52:38 +0300
Message-ID: <87efd76vl5.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On Thu, Sep 20, 2018 at 03:45:37PM +0300, Alexander Shishkin wrote:
>> Hi,
>> 
>> These are patches I have queued so far, that I'm planning to send to
>> Greg for the next merge window. This is mainly support for MIPI SyS-T
>> protocol and all the infrastructure changes to make it possible.
>> 
>> MIPI SyS-T is a public standard [0] for a software-level trace protocol
>> that in this instance we use on top of STM devices (if we choose to) and
>> MIPI STP protocol.
>> 
>> The old "protocol" is preserved for compatibility.
>
> I have tested this set on my side and things work as advertised.  Since I do not
> have a MIPI SyS-T decoder I can't validate the output, but the mechanic behind
> the functionality is simple and trivial to use.  I think you have succeeded in
> introducing something that could have otherwise been messy. 
>
> Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks a bunch! An update is coming up.

Cheers,
--
Alex
