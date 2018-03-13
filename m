Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeCMKBX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:01:23 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:13902 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752206AbeCMKBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:01:22 -0400
Subject: Re: [PATCH v1 0/4] perf annotate: Create a new '--tui-dump' option
To: Jin Yao <yao.jin@linux.intel.com>
References: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Mason <slash.tmp@free.fr>
Message-ID: <a83638c5-9f0d-18bf-1af5-c9ec218ab4f4@free.fr>
Date: Tue, 13 Mar 2018 11:01:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.2
MIME-Version: 1.0
In-Reply-To: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2018 15:16, Jin Yao wrote: [snip]

There seems to be something wonky about your system's clock?

The Date field in your messages:

	Date: Tue, 13 Mar 2018 22:16:50 +0800

i.e. 14:16:50 GMT

Yet it was actually processed at 06:20:35 GMT

So it looks like your clock is 7h56 ahead of the actual time.

Regards.
