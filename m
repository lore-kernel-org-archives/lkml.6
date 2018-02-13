Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964868AbeBMNRE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:17:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:37375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964775AbeBMNRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:17:02 -0500
Subject: Re: RFC: build config via DT names
To: Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <63f25fea-f163-f9cc-b5b2-f6f291d7f8d2@gmx.de>
 <d55f95cc-228b-e65f-b46c-2f314f4fa582@gmail.com>
 <52140da5-0d49-c861-d752-8de9e4927380@gmail.com>
From: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Message-ID: <1b395f6c-5a07-6f44-3b16-7a06a273e291@gmx.de>
Date: Tue, 13 Feb 2018 13:16:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <52140da5-0d49-c861-d752-8de9e4927380@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vgK5anKX7EQpjv3sSEQWXJMc39glH7AmVNm/mzWq9ksuRa2SFK5
 jdQD1+GX5u18Wsmc+i+bkt4lWrnxn285ah98KGjRd1vUQyeI/YmIYoifL0q3RqXYs124l6V
 PB3C+483GtPc+wUcEI3uXRlZo06jP5mNuOSy/ptqHBD1OFU7sG2PQBSZac+2ga5tl2lklMO
 3Uvvc+AXOsG9eYcTMmwIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:waFjGFyXhjM=:vvgeoMWQv0HN0tW5c13MdF
 vrZHFT8Tm9xOtZ7Iiz0LX1jX9O6c6obEpJsscGmci6+U9RS9UNQ3+fO9P9M9Hn8JjeYMDjz1n
 GR9a5ZfJm5HvHZQ0cPHGTLKUsP66BwQeY3T82tb/osg+XZK9ALTqW9PCEtbWhy0YHQrgHuXAY
 RYOzHwl5qas+drHwrrT+oFlN32phl1qO1IvY0/UX+Q+s4tg3JjDV9y+K+TtwnqDUNZ2dYkStI
 SVPSto1o9UAGo1aUWyLw0uTof0J8YgEGpSCY2As+yWIAhmlmM42Y/aicx9fuVZITeiYt9rtmO
 ctlkAnpgpN3C+iGyFv1M6jbQ0xYyghBrFy3HJ9DdaCzWjvDIOkq7WyhP7VF4hOADdZN6C2kG3
 ptsmZnxCvQOqWUO/U7rzhRrJ7SQQ0u85+QLlIZtVpWYoypSYRyVeNniYG8QVaHpMwExRlj6NG
 SiD1M3QN6SGUIR8CHLfsbjhBfEuwgH0Kg4O9c4xEjwujz7DoVCUdKiDSCqY1eggedRofrA28f
 jmkRdQWQRr/LZSqxPREJNYDtA1kjdwzVcw9qojptJ/zkG4SUyYUSEXbpc9iYhXMe6WO2+vZt5
 GBf5BT91tNU6GQfU4vT+dWc8YWbN6pfvOLguypXl5pYfzja2+va62xYJEjq7FniIVM1y1vsaL
 7K6Yi8+JiCcj9nIIz8b6p68k8jiGBaY7gzJ47MO3TC9679vw3AkHH5SdAk+vjRtOTBeyYEbFQ
 A1WUm/7D8IYxLdW2iH5Yjz3MUqu1JdU+bWgka/ln8IWvuGQGNBjgD/j9D1+BdNcDJ8o5Gq6wy
 iqq49LMIgDwWbeJNF+9hnQYJ5x5IGzt5gYk9FmnlChHOgul6Ao=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.2018 23:24, Frank Rowand wrote:

> There is a tool to aid this process: scripts/dtc/dt_to_config.  It is not
> a 100% solution, but it is very helpful.
> 
> The problem is difficult enough that this tool led to a conference talk.
> The slides are at https://elinux.org/images/5/50/Dt_debugging_part_2.pdf
> which is linked to from
> https://elinux.org/Device_Tree_presentations_papers_articles#linux_kernel_configuration

I believe my approach can make this much simpler, at least for most
drivers: the maintainers would explicitly add proper config flags,
instead of letting the tool guess it.

Of course, it would take some amount of work to do that for all drivers,
but we could do that step by step.


--mtx
