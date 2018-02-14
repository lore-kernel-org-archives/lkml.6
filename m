Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162053AbeBNSdF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:33:05 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:46755 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162022AbeBNSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:33:03 -0500
Subject: Re: plan9 semantics on Linux - mount namespaces
To: Richard Weinberger <richard@sigma-star.at>
Cc: Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <4042675.OEy7g9C5ya@blindfold>
 <794929ce-0ecb-4c93-d51e-e94fcf749cfa@metux.net>
 <6753239.SmZu9LK57z@blindfold>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <54f88b0d-282d-db79-9db6-ff82a16aaa62@metux.net>
Date: Wed, 14 Feb 2018 19:32:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <6753239.SmZu9LK57z@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:qmjxcrQBnbsqyl2ZLq4aRXKGJxm+zk6h8j/+1UW9f2kmm7TMQU5
 oyDjsXsCZwIwFseeBOOX1cyHt7/s/jSTmb5cvhmYisrmKpuV9TRnDonXZsCARG8SVblnnKP
 QDF7A3e4MgT+0t+DCTSW+DQWMAN8+3qnhXT5mdysVm8CnFZryXLs38Ph92vzLkhJ8n1e7bv
 AchNqssGQC41jvgDagR7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nUdaJGFQ63Q=:P8F+eNVIwpu6Hj5xNBXyhH
 maleQXO+B5ZD2i6vfEeFFyi/PffXymxD2rrJ8RZNKsm8BuJ70HD2HvKVP3l84efGPtoFuioQg
 ZDOFAIVnhtD9hhOyfGvyN95L41QD5hrZiI5yiAq5cyE0NcAblrQdn4gurs3uoJGUee822VtOv
 4yuKfHvdYkq3LQhVH/c26Nu9yvyaezlfHBhaxbSnYgKSGUqirx6B6gw/BmrPh7TBJIQoVKkHm
 voIlVKvV4AFf/TqvfUXZtvyqai3r2ltTI/h8JYagmAHdR7xLovjgSZFm0i+PWqVeGU5+zhRzm
 Nr0wYm7i9kVvV/jToOUg0QMytgN8jyDGmNP2LrfSFKGuxDTQ5gxvh7hk4yXupWIEeN7ftl3me
 HZ2IwUh267aYmMsnBsQdbrFtjBE9SxGZ02KgR3YaXroyb6h33ra+AmBMaxOpEKoM0FqRfMFFy
 JdWct4e1ZYzUtSEBiSYKV+iL9rau/MUo8sYNHqxRmyyih9EtpQOJwzICWOqQadLIKU/FIEb9O
 jJH8JLG/vXtvoZEAHt1oUlq3ciGOCYE4p39lKNlOGadZnegupcx9SoMhcVo+FK5IC4ujogwab
 Pi7YMWz432xjOxW4h1tBLreT12sHrKToyow72Up74igBB7VTUk4cZ8SdWubJ4vdlaeIZG9X8N
 tAS0MrSPSKNGoJqDBU6xbJTabRb8snLA7GITmdD8+GLtl9WCRc8gow228ipFgZd4Z86MXdgEa
 /9rpGLHu/GrEQLFz9bXrwxW1hrYlBm3PA32/2/tQ8ECUYVx6zbuzVtEXAXVKazUZmv52ehlvQ
 nEYBd6aphRy2nIuH8U7LKftYtSvHLycwi8MTZGFjbrD6/BWXEA+KYSAyxL/IWzpSalp04n6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 19:12, Richard Weinberger wrote:

> BTW: Your issue is fixed/known. Just checked.

aha, on 1.2.28 ... I'll have to upgrade.


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
