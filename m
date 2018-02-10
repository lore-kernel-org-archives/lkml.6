Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeBJSbA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 13:31:00 -0500
Received: from mout.web.de ([212.227.15.14]:54683 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeBJSa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 13:30:57 -0500
Subject: =?UTF-8?Q?Re:_Software_evolution_around_=e2=80=9ccheckpatch.pl?=
 =?UTF-8?B?4oCdPw==?=
To: Joe Perches <joe@perches.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Jiri Kosina <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
 <20180204112346.0977e938@archlinux>
 <9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
 <87DF341A-1356-4B1B-8D25-14D5B0AAB01D@jic23.retrosnub.co.uk>
 <f008911b-c595-6e0f-d85f-076e994ae7db@users.sourceforge.net>
 <20180210145336.233c721d@archlinux> <1518274783.6579.2.camel@perches.com>
 <20180210155734.708d01b6@archlinux> <1518284577.16865.8.camel@perches.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <a988eca2-36d4-19bd-e92c-1a92e497e0da@users.sourceforge.net>
Date: Sat, 10 Feb 2018 19:30:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518284577.16865.8.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ukKuZ6dpicrWlKvzP+w4SDpgbaribzlPhRKe3WxztY4YduvmXGv
 PKEg1LEQFL/vtME+Fpi2+SYn2m7yDWKPUJztHTfvjJ2wzXPHy3EHq8xNOORPBlcEzY6NrtR
 nn3cB7MV1ZRl0CaBLS0MlU4dIFN1JuOwQviUFaqbPEnB+ZcTb+0Iz/z2WnaVpzM8n1UXQbq
 NYEK5sV6eCQ+5OwUmqvnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PdTvA8ZM3uc=:8Hyn8oMvXIkAtBP7Cty3RD
 ISwppgBOYOSjsKqpg1ROtypHhPehYS9sCpaW3zWKqor+kKOcCtB5hSBZ1Es4SjAlYMihkDiE+
 I1+jlovwYRZnpBJZgsBqGW6jMe3RzaWsUsgt8c9K5MyrDFjXlTKDdBTYdcQRZPnTa/C/mqBs9
 QJKI9Mr7N9goBRoZyKNWnVQDaCn8PkCL8vN8RDMwjzkzkYLsG2hPYYhqZT231CseJO9pABsFR
 Lbs1okqQ9FSBiRXk6O2E8TjK1SzaEj+DUYwE7pGoSDKS4SGYXs3MldU7h4yRfxSHaQX1KXxP4
 o42reNpuoXXZpYncmQC988gAfQEyLACDF/FyJThzLYZallFFLoJLOr0BZGjUyIgA8yYCTeKR7
 D/8z9WtQoFh1o7g1MI3l1t+fJXolgKAEj5hNbWdPpkVYXgg4qKG/ZgT/Hb99oo6Nyyv9futQw
 htdjvGOyyw9/htvjUKPYrMFXGdeYHGLQRSO0EGN1h5kDfYmwzBRqtODcs6/8yS7bCepZmEACW
 TNcVUryurnP+/+qs5TAFyHiIZPKJSPZuEAiBVXPgN3jUQdLx1Ev5NvuPE+/wFVGFA5kjKCyM/
 oib03AqWAYYBThOq16jM70k7SJwS7LLTiDnpiEA2RBjRx33YQPxQ3x12cjJF8aZPW+rZ+oAy5
 Z5YBa6iXbzzV+pzBYOD8AzqV7YZIol+jQx2kv4HpylJtRavKEt0Xf9yIDtJDhcJrUb37pH4xu
 MEMbJwd2+Vs7PbQiWc3z3/II88OIW9HKKxgOxUTcPUzqqZqMapikZ9HfJpfvNTOQrizX2cJKV
 3UoPvKBe9bX2a9FwPWDS1UQiUwJgyIZC90ctG1qBDKbugUTvtg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> So I think checkpatch is striking the right balance here in
>> how it warns.  Obviously if it could assess the text
>> and come to an informed decision that would be great but
>> we are some way from that ;)
> 
> The 'informed' bit is difficult as it is mostly a political problem.

I find such a view very interesting.


> I just wish Markus would improve his consistently terrible commit messages

I tried to achieve another clarification a few times.


> that just restate the action being done and detail
> _why_ a particular thing _should_ be done.

Unfortunately, it seems that no other contributors picked
corresponding opportunities up so far.

You indicated also special software development challenges in your commit
“checkpatch: attempt to find unnecessary 'out of memory' messages”.

https://lkml.org/lkml/2014/6/10/382
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebfdc40969f24fc0cdd1349835d36e8ebae05374


> His acceptance rate would improve as many of these back and forth
> replies for what trivialities he posts as patches would be minimized.

My selection of change possibilities leads to mixed integration results.

I stumbled on variations for general change resistance.

Regards,
Markus
