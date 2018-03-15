Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeCOAeM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:34:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44870 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCOAeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:34:11 -0400
Subject: Re: [RFC v2 83/83] Sysfs support.
To: Andiry Xu <jix024@eng.ucsd.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-84-git-send-email-jix024@eng.ucsd.edu>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5d16cfa-dbd2-b874-38e4-cbb9d7d783ff@infradead.org>
Date: Wed, 14 Mar 2018 17:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520705944-6723-84-git-send-email-jix024@eng.ucsd.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 10:19 AM, Andiry Xu wrote:
> Sysfs support allows user to get/post information of running NOVA instance.
> After mount, NOVA creates four entries under proc directory
> /proc/fs/nova/pmem#/:
> 
> timing_stats	IO_stats	allocator	gc

Hi,

This is all procfs, not sysfs, so the name is (or can be) confusing.

Please change it.

-- 
~Randy
