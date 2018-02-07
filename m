Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeBGJJK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:09:10 -0500
Received: from smtpcmd14161.aruba.it ([62.149.156.161]:33391 "EHLO
        smtpcmd10101.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753476AbeBGJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:09:06 -0500
Subject: Re: [PATCH] pps-gpio: implement echo pulses
To: Lukas Senger <lukas@fridolin.com>
Cc: linux-kernel@vger.kernel.org
References: <20180206155856.14562-1-lukas@fridolin.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
Date: Wed, 7 Feb 2018 10:09:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206155856.14562-1-lukas@fridolin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/18 16:58, Lukas Senger wrote:
> pps-gpio reports as having echo capability via sysfs, which is not
> actually the case. This patch implements it.
> 
> The output pin is hardcoded as 17. This should probably be configurable
> via the dtoverlay in the same way as the input pin.

No hardcoded stuff please! :-D

However thank you for your tutorial code, maybe someone will find it very useful.

Ciao,

Rodolfo

-- 

HCE Engineering                      e-mail: giometti@hce-engineering.it
GNU/Linux Solutions                          giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Cosino Project - the quick prototyping embedded system - www.cosino.it
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
