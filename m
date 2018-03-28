Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeC1KcU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:32:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50254 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeC1KcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:32:18 -0400
Date: Wed, 28 Mar 2018 12:32:16 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, Daniel Wagner <wagi@monom.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH RT] kernel/time/posix-timer: avoid schedule() while
 holding the RCU lock
Message-ID: <20180328103215.hlt4rwsnblzav2vp@linutronix.de>
References: <20180323154057.pptgxusdgfb2h6ag@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180323154057.pptgxusdgfb2h6ag@linutronix.de>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-23 16:40:57 [+0100], To linux-rt-users@vger.kernel.org wrote:

while this seems to work I am not quite happy with it and looking into
alternatives…

Sebastian
