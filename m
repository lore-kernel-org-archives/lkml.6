Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeCTHxg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:53:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33900 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeCTHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:53:33 -0400
Date: Tue, 20 Mar 2018 08:53:21 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: kbuild test robot <fengguang.wu@intel.com>
cc: Palmer Dabbelt <palmer@sifive.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:irq/core 12/13] drivers/irqchip/irq-vic.c:295:2: error:
 implicit declaration of function 'set_handle_irq'; did you mean
 'vic_handle_irq'?
In-Reply-To: <201803200516.SWlP9b4m%fengguang.wu@intel.com>
Message-ID: <alpine.DEB.2.21.1803200852590.6506@nanos.tec.linutronix.de>
References: <201803200516.SWlP9b4m%fengguang.wu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, kbuild test robot wrote:

> Hi Palmer,
> 
> FYI, the error/warning still remains.

Zapped the commit as well...
