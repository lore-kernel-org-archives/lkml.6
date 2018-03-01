Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965711AbeCAIkB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:40:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50481 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965138AbeCAIkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:40:00 -0500
Date: Thu, 1 Mar 2018 09:39:50 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        alex.shi@linaro.org, briannorris@chromium.org, marc.zyngier@arm.com
Subject: Re: [PATCH] cpu_pm: add syscore_suspend error handling
Message-ID: <20180301083950.esonqqg2m5noofdp@linutronix.de>
References: <20180301032754.146788-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301032754.146788-1-dbasehore@chromium.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-28 19:27:54 [-0800], Derek Basehore wrote:
> If cpu_cluster_pm_enter() fails, cpu_pm_exit() should be called. This
> will put the CPU in the correct state to resume from the failure.

Was this triggered or found on review? Either way it was introduced in 
  6f3eaec87b6b ("cpu_pm: call notifiers during suspend")
and I might need a stable tag.

> Signed-off-by: Derek Basehore <dbasehore@chromium.org>

Sebastian
