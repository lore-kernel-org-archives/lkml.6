Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933455AbeBLJ7i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:59:38 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbeBLJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:59:37 -0500
Date: Mon, 12 Feb 2018 10:59:30 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jia Zhang <zhang.jia@linux.alibaba.com>
cc: mingo@redhat.com, hpa@zytor.com, Jiri Olsa <jolsa@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm/64: Add vsyscall page to /proc/kcore
 conditionally
In-Reply-To: <084400a6-4b8b-4050-b92a-d3737c1a5565@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1802121058200.1158@nanos.tec.linutronix.de>
References: <1517294579-117473-1-git-send-email-zhang.jia@linux.alibaba.com> <1517294579-117473-2-git-send-email-zhang.jia@linux.alibaba.com> <20180205092644.GA23191@krava> <084400a6-4b8b-4050-b92a-d3737c1a5565@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018, Jia Zhang wrote:
> 
> Anybody else here who can give an attention on this review?

Jiri gave you perfectly valid feedback. Please address that and repost a V2.

Thanks,

	tglx
