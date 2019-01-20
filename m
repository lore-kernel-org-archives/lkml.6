Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B809C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110EA20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfAUHYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:24:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:56610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727785AbfAUHYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:24:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 931CCAF4F;
        Sun, 20 Jan 2019 20:50:54 +0000 (UTC)
Subject: Re: [PATCH v2] perf scripts python: Add Python 3 support to
 exported-sql-viewer.py
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
 <1547718344-27382-3-git-send-email-s1seetee@linux.vnet.ibm.com>
 <f086e4fb-0bbf-9e21-25e2-708b092f1636@suse.de>
 <20190120122755.1a8fe456@lwn.net>
From:   Tony Jones <tonyj@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tonyj@suse.de; prefer-encrypt=mutual; keydata=
 mQGiBEkQmbwRBACDch7wo/RzlNt2HA8jLICsO2w8yOkJ7UTzHYNn3Q83Ro0qev2KokfE3EDw
 il+vam9CDR7jIDmswHqaMe0/O+UnZtO5PlDgylZcrwNwbBzHfm/KGejbi1RBGAoETrvcfwGi
 w83bR/aDnoRXY5Ho1uphQ05/065EMpbJOOBdn9qQ4wCgv2Q6C/QeYDGsxJPRO+20nLu5K00D
 /Rde4OTZ5biM+vb6ObTmgPNeiMrTwGpMokN7audIl7njwvD+lYrlgQjmDzcaPFz29rYWwT7g
 6t6hcFgjpU1he/v3qxeQlTJoi2+u5Mqj42z//49h6DqNjT859Z/6h5IwKBo/EZC17iBIlS2G
 VXAstNiZASGiaIlONozWJ/GSjUaRA/9wZTV1nXF/+xX+qmc7SvTg1w6jWyjxVumQLoq2SeA4
 1Sy5X2IATkAGCCjbeoQGnFdbOnHRSJdlTazObgwreqGPlPnIROpr9QESkfxsaCkDiZfpl0xk
 6X069QMZBEwGAWILHYXL9UqlOjniZaU2BkVA11JEdBhyQorC8T/ji1edc7QaVG9ueSBKb25l
 cyA8dG9ueWpAc3VzZS5kZT6IYAQTEQIAIAUCSRCZvAIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheAAAoJELFYWyEf4koXGmYAoKCnbv9dhAB2vR6IvSJem1ws4HpfAJ9ZqTKiXcogBGfTPaJR
 GI9QhVUieLkCDQRJEJm8EAgAzr9Zd3v7B10ODtVc7XxbMe3W6o1FdClL9ZIgLv61zhWctafK
 DMu/MUSvxmYFq00pecD/SfX8oxArA02+sQ2E+/Zb4J7NAWIAxCfmy7VE0wDBrZH/hBapIx/L
 gVqYfZ9Rw+a4FXrlk1y8oQCwhvj+kWrm7V7olR0aPOy1NFGNUyTFSMj+pbmxiNOXdCxVUQe3
 UE1k9yA+mILjyaRanwkiCLCjNvRPL88Q017BdhVBWZmz8qhwXN/RrjCcDHsPX5O0ev68MLyu
 sh5mfukuvCqzW1Y3Ql+iwfwEw5lNmQGdoV9csg7JP7saDicSFO2KcZvMbvDMqtPFipdF5UWo
 fZKZ3wADBQf/b5cVNyb5i8QI0G7BPGBNn4VlQX5n66TsPBnrRNOi3MhTTVEBCp8s+jqUjJjX
 EjjA+O4hIm7Qqdsozurw7GlcQ0A06dIzO/1RUglZZMoC0JL43ZQmJ+3+yFrLjWgGH6ev6AOb
 YLH7ZujgAB5n0Hy2ZIChzsKLKbHptFtBvpDKB8updq+GunsY4oN3wGa67h9sHqDvjyp64Czg
 n8G5uGLwx3f/edbECKz5kPUSzChEk3suK742SEP01v4ra5WX88Hn81NjGByQMz9acJLdC7Ff
 LzXvbNa0KgvDaSllYfsJIoGCz3eKVOuTWXOiaEIKuy833+3mr2PulLCyLKysAEddKohJBBgR
 AgAJBQJJEJm8AhsMAAoJELFYWyEf4koXhgQAn1EGATLZPS53At9t+p3S8BkNI9yRAJ9A0OmL
 liv+rwEesYGlGeGNaKHTJw==
Message-ID: <6c3d7574-f9cf-d86a-16af-43fa9929015b@suse.de>
Date:   Sun, 20 Jan 2019 12:50:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190120122755.1a8fe456@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/19 11:27 AM, Jonathan Corbet wrote:
> On Fri, 18 Jan 2019 16:45:04 -0800
> Tony Jones <tonyj@suse.de> wrote:
> 
>> On 1/17/19 1:45 AM, Seeteena Thoufeek wrote:
>>
>>> +if sys.version_info[0] < 3:
>>> +    import cPickle
>>> +else:
>>> +    import _pickle as cPickle  
>>
>> Do you really need this?
>>
>> pickle is already in Python2.
> 
> Did you mean in Python3?  I would agree that using it is better than
> importing the semi-hidden _pickle module.

No.  I meant Python2 :)   

pickle in Python2 is the python implementation
cPickle in Python2 is the C implementation.

Read: https://docs.python.org/3.1/whatsnew/3.0.html#library-changes
A common pattern in Python 2.x is to have one version of a module implemented in pure Python, with an optional accelerated version implemented as a C extension; for example, pickle and cPickle. This places the burden of importing the accelerated version and falling back on the pure Python version on each user of these modules. In Python 3.0, the accelerated versions are considered implementation details of the pure Python versions. Users should always import the standard version, which attempts to import the accelerated version and falls back to the pure Python version. 

I my patchset "import pickle" was sufficient for Python2 and Python3  The question I suppose is whether this script,  for Python2,  needs the accelerated C implementation.  I decided it didn't.

Tony

