Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789B2C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B202253B6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B202253B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeFYBLw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 21:11:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:10287 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752284AbeFYBLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 21:11:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2018 18:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,268,1526367600"; 
   d="scan'208";a="51581992"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2018 18:11:34 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.228]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.63]) with mapi id 14.03.0319.002;
 Sun, 24 Jun 2018 18:11:34 -0700
From:   "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
To:     "Tobin C. Harding" <me@tobin.cc>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] docs: e100[0] fix build errors
Thread-Topic: [PATCH 0/4] docs: e100[0] fix build errors
Thread-Index: AQHUCcE3/2vyfok2SEKqCgpKEkCa8qRtL1uAgANcQYD//6PLcw==
Date:   Mon, 25 Jun 2018 01:11:33 +0000
Message-ID: <91A1572C-63A6-4420-B01B-A0DD5F84200A@intel.com>
References: <20180622003708.31848-1-me@tobin.cc>
 <ba768d6c-dd21-3600-5cba-151b5d6185f1@infradead.org>,<20180624234135.GE3006@eros>
In-Reply-To: <20180624234135.GE3006@eros>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 24, 2018, at 16:41, Tobin C. Harding <me@tobin.cc> wrote:
> 
>> On Fri, Jun 22, 2018 at 01:22:37PM -0700, Randy Dunlap wrote:
>> Hi Tobin,
>> 
>>> On 06/21/2018 05:37 PM, Tobin C. Harding wrote:
>>> Hi Jonathan,
>>> 
>>> This patch set fixes current docs build failure on Linus' mainline
>>> 
>>> commit: (ba4dbdedd3ed Merge tag 'jfs-4.18' of git://github.com/kleikamp/linux-shaggy)
>>> 
>>> (FYI this is 8 commits after Linux 4.18-rc1).
>>> 
>>> And also same build errors on today's linux-next
>>> 
>>> 8439c34f07a3 (tag: next-20180621, linux-next/master, linux-next) Add linux-next specific files for 20180621
>>> 
>>> 
>>> I split the patches in between the two drivers to enable use of the
>>> 'Fixes:' tag.
>>> 
>>> Tobin C. Harding (4):
>>>  Documentation: e100: Use correct heading adornment
>>>  Documentation: e1000: Use correct heading adornment
>>>  Documentation: e100: Fix docs build error
>>>  Documentation: e1000: Fix docs build error
>>> 
>>> Documentation/networking/e100.rst  | 112 +++++++++++++++--------------
>>> Documentation/networking/e1000.rst |  76 ++++++++++----------
>>> 2 files changed, 96 insertions(+), 92 deletions(-)
>> 
>> I am still seeing a few warnings (your 4 patches applied to
>> linux-next-20180622):
>> 
>> linux-next-20180622/Documentation/networking/e100.rst:57: WARNING: Literal block expected; none found.
>> linux-next-20180622/Documentation/networking/e100.rst:68: WARNING: Literal block expected; none found.
>> linux-next-20180622/Documentation/networking/e100.rst:75: WARNING: Literal block expected; none found.
>> linux-next-20180622/Documentation/networking/e100.rst:84: WARNING: Literal block expected; none found.
>> linux-next-20180622/Documentation/networking/e100.rst:93: WARNING: Inline emphasis start-string without end-string.
>> linux-next-20180622/Documentation/networking/e1000.rst:83: ERROR: Unexpected indentation.
>> linux-next-20180622/Documentation/networking/e1000.rst:84: WARNING: Block quote ends without a blank line; unexpected unindent.
>> linux-next-20180622/Documentation/networking/e1000.rst:173: WARNING: Definition list ends without a blank line; unexpected unindent.
>> linux-next-20180622/Documentation/networking/e1000.rst:236: WARNING: Definition list ends without a blank line; unexpected unindent.
>> 
>> 
>> You didn't get these warnings?  or they weren't important?
>> or "perfect" was not your primary goal?   :)   [which is fine]
>> 
>> [I see around 50 similar doc formatting warnings/errors in the entire
>> Documentation build.]
> 
> Thanks for testing this Randy.  You are right there are a bunch of
> warnings, I did not think to grep for warnings on these files - sloppy
> work by me.  The series has been applied already but I'll add clearing
> these warnings to my TODO list.

Thanks, already on it.  I have a set of patches that I will push once Dave open’s up his net-next tree.

> 
>> Anyway, much better than it was.  Thanks.
>> 
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks again,
> Tobin.
