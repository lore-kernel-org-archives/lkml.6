Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBWIUZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:20:25 -0500
Received: from mout.web.de ([217.72.192.78]:54007 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbeBWIUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:20:23 -0500
Subject: Re: [0/8] target-iSCSI: Adjustments for several function
 implementations
To: David Disseldorp <ddiss@suse.de>, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Arun Easi <arun.easi@cavium.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jiang Yi <jiangyilism@gmail.com>, Kees Cook <keescook@chromium.org>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tang Wenji <tang.wenji@zte.com.cn>, "Theodore Ts'o" <tytso@mit.edu>,
        Varun Prakash <varun@chelsio.com>
References: <6163538d-a406-2f60-11a2-88b4694e9975@users.sourceforge.net>
 <c9a822a4-248e-c479-9118-4b8ffb1033b1@users.sourceforge.net>
 <20180222143624.7c7241a1@suse.de>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <da62858f-37f5-1396-c561-ab68ba20c811@users.sourceforge.net>
Date: Fri, 23 Feb 2018 09:19:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222143624.7c7241a1@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:fiF+imzW7k2hsrNuYjkYKkKHg0/fXC3HcTK7ClQnkS32TuHs/qx
 +YT0wZx6oLdGSArDb50r6oqpXbs9JzHdBBL82Yzwa92KnfOplFkZVzhenqBmTcS5a2gGbWZ
 3beMHYmuH4sdPa9q+KD7uOWW33O//ILbX34rTNObQWHEmIBkigpuwEZsAd34k2ImhewZHFJ
 rWiTEcK3EO1aoWHQq3e/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XMWWjXyCPk4=:0VouFVvqF+EKYOXiUlo/yz
 TNb5Q7U9NYOEFWL534Qf3DbuRa3mIgZmmm4WIJ08oX0C2m8XTt26FQ8Z1lmM2LyYyoe8NNWos
 7c8Q9Xxxl/hgkLjaB/q5C2CoYCVIzzYIwyRkJpRZVLovoEXSXEWSHAvym/MbUkOoFdRsGKyb3
 6WGz7u+/xWKzM0BPALEUQdPpBx/QJxLlcG6Vj348Za1FdI/RNMAlHheRO0SdrWhvmt+KOuw5e
 9+/8UwIW+PoAiHUEeNJXnaxL76+1TgGQZwKTIROvCoz+AzMjy+vONpWpK4fvLTXRGyYb5nwvT
 95jMhdf+Uyva3RS/UWeTLUri3XEO7YKuy5pOn+ABe1qcppF/UrK2JMMMPLlUChl5QL9WjcZH8
 FCkQjqerN04BA3XCRy0aBZVVPsPCwfmZHnVuzLdDTUEKzp+bP0ufvi2kDImV1XYHLBerwqqld
 fP6HazE5Z89M5fvO45YkcrJ7Sw0AyhlkznydyKOihj9jqUkcleCmmyas5WeErUaoLHhJvAO6A
 NKdG0WtmmONhfrG8K6HQcaHofrWKstCVN+9/HTuUz1gAKX7mUbzjSS35bKvlc1fIpVwm/MDSn
 EKS+T/XOSrcycEJUu7Yf+R9tJCmvaQoW4f0uCAei4GOWfMI9oIKJZnVCKyzoNiJhBtL6GdREr
 LC1dlCwSgSsim6FxGtF0N+I4I05vD9FmU42EqFb5SA2ysdpHmMjY6ZjuZfo6UXeCHEC8ViGKq
 +AVY4vduAMuG3R/w7N/9dEGr9JHT+DukMinQijwOJrVlp0kTriluMOTsLauKonwOI6O5Umv8W
 Bn1526MKJ93/J+Di9awyDQBdyTuKPzeaJKvDMjt8bdqYKAewH8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You're 1/8 patch had an actual bug fix hidden amongst the style churn.

It showed the general possibility to adjust the source code structure
for the function “chap_server_compute_md5” also because of the usage
of the single jump label “out” before.


> I don't see any such fixes in the other patches.

This view is appropriate.

Further update steps show different transformation possibilities.


> My opinion from https://www.spinics.net/lists/target-devel/msg16342.html
> hasn't changed. FWIW, I'd prefer to see LIO adopt a policy similar to:
> https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#How_not_to_start

It seems that you express a few aspects for general change resistance.
Will the circumstances evolve for similar software improvements?

Regards,
Markus
