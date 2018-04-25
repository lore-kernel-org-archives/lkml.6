Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeDYUns (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 16:43:48 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:40743 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeDYUnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 16:43:45 -0400
X-IronPort-AV: E=Sophos;i="5.49,327,1520899200";
   d="scan'208";a="104459763"
To: Phillip Lougher <phillip@squashfs.org.uk>, Yixia Si <yisi@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
From: Daniel Walker <danielwa@cisco.com>
Subject: config option for SQUASHFS_CACHED_BLKS,
Message-ID: <63c599b5-0ac1-6d37-920f-33d502e33dfb@cisco.com>
Date: Wed, 25 Apr 2018 13:34:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


We have found that we can attain a better boot time by increasing 
SQUASHFS_CACHED_BLKS from 8 to 11. We also noticed that you made a 
special config option for allow people to configure fragment cache size 
(i.e. SQUASHFS_FRAGMENT_CACHE_SIZE).


Is there anything unsafe about altering the value of SQUASHFS_CACHED_BLKS ?


Would you be open to accepting a patch to add a config option for this 
similar to the pre-existing SQUASHFS_FRAGMENT_CACHE_SIZE ?


Thanks,

Daniel
