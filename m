Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeBJIkN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 03:40:13 -0500
Received: from mout.web.de ([212.227.15.4]:60253 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeBJIkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 03:40:11 -0500
Subject: Re: Adjustments for a lot of function implementations
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Jan Kara <jack@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Muralidharan Karicheri <mkaricheri@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <f9dc652b-4fca-37aa-0b72-8c9e6a828da9@users.sourceforge.net>
 <356f75b2-d303-7f10-b76c-95e2f686bd3c@xs4all.nl>
 <14619198-bebe-d215-5324-a14fbc2103fb@users.sourceforge.net>
 <alpine.DEB.2.20.1710301745530.2160@hadrien>
 <ebf37d57-38c6-b3de-5a66-dbb1c13fd63a@xs4all.nl>
 <049aa1b4-6291-ec24-1ffb-77ae8d1cdb63@users.sourceforge.net>
 <804550a6-1096-12f1-a0ec-1ccd6bcc191e@xs4all.nl>
 <f082b1ae-1be4-440a-6a81-68446c67243e@users.sourceforge.net>
 <ca67319a-622b-e35e-dfb5-045dd04b4deb@xs4all.nl>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <26a090fe-fb39-8f68-aa4e-ce4f9f6b0781@users.sourceforge.net>
Date: Sat, 10 Feb 2018 09:39:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ca67319a-622b-e35e-dfb5-045dd04b4deb@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:pHDC6JxiOfZxDLxD721iaYqKjVX+hWThmuJeyNtj/0EZ2Hh9AmG
 pRq9kaVgBBm4PkXYFPs52G+n76WmVfjTxDvhIgiFDxgXYjNcsMFwvvOWXQdaP3QZ3bYsUUR
 3qdKr0HTSJwTwrCryeeIxrlJs0n4j3TjkB6v2C4Ywd0FPZosratH4/wvlgH1m8DqIWAWxr9
 n4cWW1euyh3Gt0JxCWHIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mwePOT4Pi8Q=:HUm/5P7AquErM9FzERi2sd
 JjQohdIa1e1mwb+LBEmR0QN8tdGjT9Y8EOzgQ3xEuO/os9H0rirRXSS7uTkVxBLnMdv16Xx1v
 QRjfacv7jMlsH4SNWQRYXLy/TJ7uL4lwHjnJcpIw0J51ufOa6/PTqt/Qg9cjbhtClg+b267fc
 c/kMSySQGqAQVMoa9C6uEupYF9yX07kPaaKWlgHGDCIU0nfg1BHc5qGQ2X8j71QkK6CWQgqQG
 jGDrBllurxjxzojHPQ9o9Rh+Rc/Auz92+E/Xa5QJ6MSfq6cnzpFd9EcLqRWBIDENBD89xcaC8
 k2o/XwZOlQtucOQOhNzCgd4XLfD0gUxqIAyK/6oLZwYK0pfoFZ0MxAyvYiCeWSrWn0Ni1JOCC
 Di7+x/apwXkPKjTeHR9Qtf1r6XxIKKWVEutIdwyuUxUdek5v6l+3xNiezPHyw/GSf39jL2exH
 gXwJtaLaPUd8UabVQMZ93tjtXL7BGOSbqaRnPd71vWgpKvViBBUVdm72n5QJYyhyb6fOhIjY+
 Djyuays462/t41sYBEcRdErm0ePRim8byzSUPNAEy2GHbK1fnX4amZE+xMP+O7ybHDa9a+J0U
 Q15eQ9k93QBZ4g0K7dvK5TF5JgJsBF0S0jc/tk7ZeLefWQPQ4ynwFou20MPth9sdxXjA7F50Z
 RBvqnzsvDxAo66WFeSAXB1q15sN37IL1IC7pujYF8W1WPptzLSy8SPpjIJtckQD77s+eLLdSa
 ZaseApKXzXw1iV2nBlmhsYsxA0nD4BPXw28hzvIGUfcT3DABAliTDdhogyDEEA4ik30GlV43D
 gwRg25aVMuCKvMCFlG8MzaEGPkG3tsGSwR9mL+sZhFv3QD14RY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Do any contributors get into the mood to take another look at software updates
>> from my selection of change possibilities in a more constructive way?
>>
>> Do you need any additional development resources?
> 
> One last time: either post per-driver patches with all the cleanups for a driver
> in a single patch,

I find such a change combination unsafe.


> or a per-directory patch (drivers/media/pci, usb, etc) doing the same cleanup
> for all drivers in that directory.

Would you dare to apply any (of my) scripts for the semantic patch language
directly on the whole directory for multi-media software?


> I prefer the first approach, but it's up to you.

Can you handle bigger patches really better than similar patch series?


> We don't have the time to wade through dozens of one-liner cleanup patches.

Are there any further possibilities to consider around consequences
from a general change resistance?

Will any development (or management) tools like “quilt fold” make the regrouping
of possible update steps more convenient and safer? 

Regards,
Markus
