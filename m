Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422889AbeBOPg3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:36:29 -0500
Received: from smtpweb130.aruba.it ([62.149.158.130]:50357 "EHLO
        smtpweb130.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422875AbeBOPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:36:27 -0500
Subject: Re: [PATCH 1/2] pps-gpio: Avoid flooding syslog
To: Lukas Senger <lukas@fridolin.com>
Cc: linux-kernel@vger.kernel.org
References: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
 <20180215125921.29494-1-lukas@fridolin.com>
 <20180215125921.29494-2-lukas@fridolin.com>
 <6c424674-e8f0-eaf1-c056-889e354b43b7@enneenne.com>
 <20180215161238.23e0c117@dinghy.localdomain>
From: Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <a9b965fe-fee2-3aab-0f2c-681d2835070c@enneenne.com>
Date: Thu, 15 Feb 2018 16:36:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215161238.23e0c117@dinghy.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/18 16:12, Lukas Senger wrote:
> 
>> Why a void function? You should use it to toggle echoing GPIO... =8-o
> 
> RFC 2783 says to generate the echo pulse "as rapidly as possible" which
> is why I do the toggling in the irq handler. However this leaves the
> default echo function installed which just floods syslog.

The pps_event() function does it for you in a beauty-and-clear way by using the 
info.echo() function. :-D

> Another problem with this patch is that it also is against my old one
> and not against current kernel code.

Yes, correct it please.

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
