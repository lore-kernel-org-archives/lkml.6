Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeCUKbF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:31:05 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:39071 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeCUKbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:31:01 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Edgar Thier <info@edgarthier.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [lkp-robot] [media]  859086ae36: kmsg.uvcvideo:Failed_to_query(GET_INFO)UVC_control#on_unit#:-#(exp.#)
Date: Wed, 21 Mar 2018 12:32:07 +0200
Message-ID: <1637940.NKPajzO43a@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180316020039.GU8942@yexl-desktop>
References: <20180316020039.GU8942@yexl-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Friday, 16 March 2018 04:00:39 EET kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 859086ae3636eae0bf9f0fbbce2daf4d41ae9474 ("media: uvcvideo: Apply
> flags from device to actual properties")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: netperf
> with following parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 1
> 	cluster: cs-localhost
> 	test: SCTP_STREAM
> 	cpufreq_governor: performance
> 
> test-description: Netperf is a benchmark that can be use to measure various
> aspect of networking performance. test-url: http://www.netperf.org/netperf/
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz with 4G
> memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
> 
> 
> [   76.108373] uvcvideo: Failed to query (GET_INFO) UVC control 11 on unit
> 1: -32 (exp. 1).

Just for the record, Kieran is working on this.

> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml

-- 
Regards,

Laurent Pinchart
