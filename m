Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeFDGtd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:49:33 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:44552 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeFDGtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:49:32 -0400
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.220.135
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [PATCH v4 2/2] sched/deadline: Set cp->elements[0].cpu to -1 when
 the heap is empty
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org
Cc: tglx@linutronix.de, raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com,
        joel@joelfernandes.org
References: <1528094207-15567-1-git-send-email-byungchul.park@lge.com>
 <1528094207-15567-2-git-send-email-byungchul.park@lge.com>
Message-ID: <06e1b103-8385-aea0-3e03-2054ac15f9a4@lge.com>
Date: Mon, 4 Jun 2018 15:49:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528094207-15567-2-git-send-email-byungchul.park@lge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-06-04 15:36, Byungchul Park wrote:
> Hello Steven and Daniel,
> 
> I've changed the 2nd patch a little bit to consider cpudl_clear()
> additionally. Can I keep your Acked-by on?

Very sorry. Please ignore this v4 spin.. I'll resend v5 version soon.

-- 
Thanks,
Byungchul
