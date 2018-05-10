Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965614AbeEJOvj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:51:39 -0400
Received: from pindarots.xs4all.nl ([82.161.210.87]:42552 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935624AbeEJOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:51:38 -0400
Subject: Re: 4.16.8 do_IRQ: 1.37 No irq handler for vector
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <7aaa7bf4-461f-1882-3762-b06b95aca0d5@xs4all.nl>
From: Udo van den Heuvel <udovdh@xs4all.nl>
Organization: hierzo
Message-ID: <73252715-8772-9b12-cecf-1727bf847476@xs4all.nl>
Date: Thu, 10 May 2018 16:51:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <7aaa7bf4-461f-1882-3762-b06b95aca0d5@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-05-18 16:26, Udo van den Heuvel wrote:
> May 10 16:00:04 v kernel: do_IRQ: 1.37 No irq handler for vector
> May 10 16:00:04 v kernel: do_IRQ: 1.37 No irq handler for vector

These appear every ~25 minutes:

May 10 16:00:04 v kernel: do_IRQ: 1.37 No irq handler for vector
May 10 16:00:04 v kernel: do_IRQ: 1.37 No irq handler for vector
May 10 16:25:03 v kernel: do_IRQ: 1.37 No irq handler for vector
May 10 16:25:03 v kernel: do_IRQ: 1.37 No irq handler for vector
May 10 16:50:03 v kernel: do_IRQ: 1.37 No irq handler for vector
May 10 16:50:03 v kernel: do_IRQ: 1.37 No irq handler for vector

Udo
