Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965997AbeEJO0H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:26:07 -0400
Received: from pindarots.xs4all.nl ([82.161.210.87]:42014 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965708AbeEJO0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:26:04 -0400
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 4.16.8 do_IRQ: 1.37 No irq handler for vector
Organization: hierzo
Message-ID: <7aaa7bf4-461f-1882-3762-b06b95aca0d5@xs4all.nl>
Date: Thu, 10 May 2018 16:26:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My Asrock QC5000M-ITX/PH baord booted into 4.16.8 recently and after a
while we noticed messages like:

May 10 16:00:04 v kernel: do_IRQ: 1.37 No irq handler for vector
May 10 16:00:04 v kernel: do_IRQ: 1.37 No irq handler for vector


How can we fix this these? (previous kernel did not produce these)

Kind regards,
Udo
