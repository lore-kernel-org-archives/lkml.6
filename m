Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeEBXa2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 19:30:28 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:47636 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeEBXa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 19:30:26 -0400
X-IronPort-AV: E=Sophos;i="5.49,356,1520899200";
   d="scan'208";a="379295479"
Subject: Re: config option for SQUASHFS_CACHED_BLKS,
From: Daniel Walker <danielwa@cisco.com>
To: Phillip Lougher <phillip@squashfs.org.uk>, Yixia Si <yisi@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
References: <63c599b5-0ac1-6d37-920f-33d502e33dfb@cisco.com>
Message-ID: <a064ddeb-7b0b-8ff3-78df-3df6344d3edb@cisco.com>
Date: Wed, 2 May 2018 16:21:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <63c599b5-0ac1-6d37-920f-33d502e33dfb@cisco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/2018 01:34 PM, Daniel Walker wrote:
>
> Hi,
>
>
> We have found that we can attain a better boot time by increasing 
> SQUASHFS_CACHED_BLKS from 8 to 11. We also noticed that you made a 
> special config option for allow people to configure fragment cache 
> size (i.e. SQUASHFS_FRAGMENT_CACHE_SIZE).
>
>
> Is there anything unsafe about altering the value of 
> SQUASHFS_CACHED_BLKS ?
>
>
> Would you be open to accepting a patch to add a config option for this 
> similar to the pre-existing SQUASHFS_FRAGMENT_CACHE_SIZE ? 


Phillip, did you have any comments on this ?

Daniel
