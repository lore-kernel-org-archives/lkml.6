Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66B9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA1821852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbeLTPXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:23:43 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:48092 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729211AbeLTPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:23:42 -0500
Received: from ip4d142c80.dynamic.kabel-deutschland.de ([77.20.44.128] helo=[192.168.66.118]); authenticated
        by wp227.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ga0Al-000548-5U; Thu, 20 Dec 2018 16:23:39 +0100
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181217152043.9989-1-linux@leemhuis.info>
 <20181217112437.5fe868eb@lwn.net>
 <8f67a8ca-bf64-c537-843a-b03bcfc3dace@infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@leemhuis.info; prefer-encrypt=mutual; keydata=
 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
 5iv6NKaV29GWHbY=
Subject: Re: [PATCH 0/1] RFC: Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
Message-ID: <96fc8865-c54f-5c6c-f6c8-d7a5a12735e6@leemhuis.info>
Date:   Thu, 20 Dec 2018 16:23:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <8f67a8ca-bf64-c537-843a-b03bcfc3dace@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------A008BE2F2FE00B944C7960DA"
Content-Language: en-MW
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1545319421;8f31ef13;
X-HE-SMSGID: 1ga0Al-000548-5U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A008BE2F2FE00B944C7960DA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi! Am 17.12.18 um 22:06 schrieb Randy Dunlap:
> On 12/17/18 10:24 AM, Jonathan Corbet wrote:
>> Here's an idea if you feel like improving this: rather than putting an
>> inscrutable program inline, add a taint_status script to scripts/ that
>> prints out the status in fully human-readable form, with the explanation
>> for every set bit.
> And some people prefer not adding tools that use python, perl, etc.

Yeah, I know :-/ On twitter @apexo (thx!) suggested these two:

dc -e"[00000000000000]n2o$(cat /proc/sys/kernel/tainted)p"|fold
-w1|tac|nl| grep  -m 18 '.'

(echo -n 000000000000000;(echo obase=2;cat
/proc/sys/kernel/tainted)|bc)|fold -w1|tac|nl| grep -m 18 '.'

But it needs bc, which often is not installed by default  :-/ Any as you
mentioned already: using Perl (

perl -e 'printf("%016b\n",<STDIN>)' < /proc/sys/kernel/tainted |fold
-w1|tac|nl

) also has it downsides. Having something that works in plain bash/sh
would be great...

Nevertheless: I'm still inclined to put a one liner decode command into
tainted-kernels.rst so people can decode the file easily even if they do
not have attached script at hand.

> E.g., I use this shell script (named 'chktaint', which could probably
> be done better):

Many thx. Find a slightly improved version attached that directly prints
the reason. I assume that's more like what Jonathan had in mind. The
script now is also capable of decoding a value retrieved from
/proc/sys/kernel/tainted on another system.

Randy, do you spot any problems or bashisms in the code? BTW, can I have
your "Signed-off-by" for the submission?

While at it: Jonathan, you mentioned putting the script in scripts/, but
according to the Makefile in that directory it is "for various helper
programs used throughout the kernel for the build process". That's one
reason why it feels wrong to put it there. Another one: that script
targets users and thus we should try to make sure they can access it
easily. That's why I'm currently inclined to put it in tools/ somewhere.
But I'm still unsure where. tools/scripts/ is used for something else
already, so maybe tools/helper-scripts/ or something? Putting it there
and installing it by default when building tools/ afaics increases the
chances a lot that distros will actually ship it in their packages that
contain tools from that directory.

Ciao, Thorsten

--------------A008BE2F2FE00B944C7960DA
Content-Type: text/plain; charset=UTF-8;
 name="kernel-taintstatus"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="kernel-taintstatus"

IyEgL2Jpbi9zaAojIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCiMKIyBSYW5k
eSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4sIDIwMTgKIyBUaG9yc3RlbiBMZWVt
aHVpcyA8bGludXhAbGVlbWh1aXMuaW5mbz4sIDIwMTgJCgp1c2FnZSgpCnsKCWNhdCA8PEVP
Rgp1c2FnZTogJHswIyMqL30KICAgICAgICR7MCMjKi99IDxpbnQ+CgpDYWxsIHdpdGhvdXQg
cGFyYW1ldGVycyB0byBkZWNvZGUgL3Byb2Mvc3lzL2tlcm5lbC90YWludGVkLgoKQ2FsbCB3
aXRoIGEgcG9zaXRpdmUgaW50ZWdlciBhcyBwYXJhbWV0ZXIgdG8gZGVjb2RlIGEgdmFsdWUg
eW91CnJldHJpZXZlZCBmcm9tIC9wcm9jL3N5cy9rZXJuZWwvdGFpbnRlZCBvbiBhbm90aGVy
IHN5c3RlbS4KCkVPRgp9CgppZiBbICIkMSJ4ICE9ICJ4IiBdOyB0aGVuCglpZiAgWyAiJDEi
eCA9PSAiLS1oZWxweCIgXSB8fCBbICIkMSJ4ID09ICItaHgiIF0gOyB0aGVuCgkJdXNhZ2UK
CQlleGl0IDEKCWVsaWYgIFsgJDEgLWdlIDAgXSAyPi9kZXYvbnVsbCA7IHRoZW4KCQl0YWlu
dD0kMQoJZWxzZQoJCWVjaG8gIkVycm9yOiBQYXJhbWV0ZXIgJyQxJyBub3QgYSBwb3NpdGl2
ZSBpbnRlcmdlci4gQWJvcnRpbmcuIiA+JjIKCQlleGl0IDEKCWZpCmVsc2UKCVRBSU5URklM
RT0iL3Byb2Mvc3lzL2tlcm5lbC90YWludGVkIgoJaWYgWyAhIC1yICRUQUlOVEZJTEUgXTsg
dGhlbgoJCWVjaG8gIk5vIGZpbGU6ICRUQUlOVEZJTEUiCgkJZXhpdAoJZmkKCgl0YWludD1g
Y2F0ICRUQUlOVEZJTEVgCmZpCgppZiBbICR0YWludCAtZXEgMCBdOyB0aGVuCgllY2hvICJL
ZXJuZWwgbm90IFRhaW50ZWQiCglleGl0CmVsc2UKCWVjaG8gIktlcm5lbCBpcyBUYWludGVk
IGZvciBmb2xsd2luZyByZWFzb25zOiIKZmkKClQ9JHRhaW50Cm91dD0KCmFkZG91dCgpIHsK
CW91dD0kb3V0JDEKfQoKaWYgWyBgZXhwciAkVCAlIDJgIC1lcSAwIF07IHRoZW4KCWFkZG91
dCAiRyIKZWxzZQoJYWRkb3V0ICJQIgkKCWVjaG8gIiAqIFByb3ByaWV0YXJ5IG1vZHVsZSB3
YXMgbG9hZGVkLiIKZmkKClQ9YGV4cHIgJFQgLyAyYAppZiBbIGBleHByICRUICUgMmAgLWVx
IDAgXTsgdGhlbgoJYWRkb3V0ICIgIgplbHNlCglhZGRvdXQgIkYiCgllY2hvICIgKiBNb2R1
bGUgd2FzIGZvcmNlIGxvYWRlZC4iCmZpCgpUPWBleHByICRUIC8gMmAKaWYgWyBgZXhwciAk
VCAlIDJgIC1lcSAwIF07IHRoZW4KCWFkZG91dCAiICIKZWxzZQoJYWRkb3V0ICJTIgoJZWNo
byAiICogU01QIGtlcm5lbCBvb3BzIG9uIGFuIG9mZmljaWFsbHkgU01QIGluY2FwYWJsZSBw
cm9jZXNzb3IuIgpmaQoKVD1gZXhwciAkVCAvIDJgCmlmIFsgYGV4cHIgJFQgJSAyYCAtZXEg
MCBdOyB0aGVuCglhZGRvdXQgIiAiCmVsc2UKCWFkZG91dCAiUiIJCgllY2hvICIgKiBNb2R1
bGUgd2FzIGZvcmNlIHVubG9hZGVkLiIKZmkKClQ9YGV4cHIgJFQgLyAyYAppZiBbIGBleHBy
ICRUICUgMmAgLWVxIDAgXTsgdGhlbgoJYWRkb3V0ICIgIgplbHNlCglhZGRvdXQgIk0iCgll
Y2hvICIgKiBQcm9jZXNzb3IgcmVwb3J0ZWQgYSBNYWNoaW5lIENoZWNrIEV4Y2VwdGlvbiAo
TUNFKS4iCmZpCgpUPWBleHByICRUIC8gMmAKaWYgWyBgZXhwciAkVCAlIDJgIC1lcSAwIF07
IHRoZW4KCWFkZG91dCAiICIKZWxzZQoJYWRkb3V0ICJCIgoJZWNobyAiICogQmFkIHBhZ2Ug
cmVmZXJlbmNlZCBvciBzb21lIHVuZXhwZWN0ZWQgcGFnZSBmbGFncy4iCmZpCgpUPWBleHBy
ICRUIC8gMmAKaWYgWyBgZXhwciAkVCAlIDJgIC1lcSAwIF07IHRoZW4KCWFkZG91dCAiICIK
ZWxzZQoJYWRkb3V0ICJVIgoJZWNobyAiICogVGFpbnQgcmVxdWVzdGVkIGJ5IHVzZXJzcGFj
ZSBhcHBsaWNhdGlvbi4iCmZpCgpUPWBleHByICRUIC8gMmAKaWYgWyBgZXhwciAkVCAlIDJg
IC1lcSAwIF07IHRoZW4KCWFkZG91dCAiICIKZWxzZQoJYWRkb3V0ICJEIgoJZWNobyAiICog
S2VybmVsIGRpZWQgcmVjZW50bHksIGkuZS4gdGhlcmUgd2FzIGFuIE9PUFMgb3IgQlVHIgpm
aQoKVD1gZXhwciAkVCAvIDJgCmlmIFsgYGV4cHIgJFQgJSAyYCAtZXEgMCBdOyB0aGVuCglh
ZGRvdXQgIiAiCmVsc2UKCWFkZG91dCAiQSIKCWVjaG8gIiAqIEFDUEkgdGFibGUgb3ZlcnJp
ZGRlbiBieSB1c2VyLiIKZmkKClQ9YGV4cHIgJFQgLyAyYAppZiBbIGBleHByICRUICUgMmAg
LWVxIDAgXTsgdGhlbgoJYWRkb3V0ICIgIgplbHNlCglhZGRvdXQgIlciCgllY2hvICIgKiBL
ZXJuZWwgaXNzdWVkIHdhcm5pbmcuIgpmaQoKVD1gZXhwciAkVCAvIDJgCmlmIFsgYGV4cHIg
JFQgJSAyYCAtZXEgMCBdOyB0aGVuCglhZGRvdXQgIiAiCmVsc2UKCWFkZG91dCAiQyIKCWVj
aG8gIiAqIFN0YWdpbmcgZHJpdmVyIHdhcyBsb2FkZWQuIgpmaQoKVD1gZXhwciAkVCAvIDJg
CmlmIFsgYGV4cHIgJFQgJSAyYCAtZXEgMCBdOyB0aGVuCglhZGRvdXQgIiAiCmVsc2UKCWFk
ZG91dCAiSSIKCWVjaG8gIiAqIFdvcmthcm91bmQgZm9yIGJ1ZyBpbiBwbGF0Zm9ybSBmaXJt
d2FyZSBhcHBsaWVkLiIKZmkKClQ9YGV4cHIgJFQgLyAyYAppZiBbIGBleHByICRUICUgMmAg
LWVxIDAgXTsgdGhlbgoJYWRkb3V0ICIgIgplbHNlCglhZGRvdXQgIk8iCgllY2hvICIgKiBF
eHRlcm5hbGx5LWJ1aWx0ICgnb3V0LW9mLXRyZWUnKSBtb2R1bGUgd2FzIGxvYWRlZCIKZmkK
ClQ9YGV4cHIgJFQgLyAyYAppZiBbIGBleHByICRUICUgMmAgLWVxIDAgXTsgdGhlbgoJYWRk
b3V0ICIgIgplbHNlCglhZGRvdXQgIkUiCQoJZWNobyAiICogVW5zaWduZWQgbW9kdWxlIHdh
cyBsb2FkZWQuIgpmaQoKVD1gZXhwciAkVCAvIDJgCmlmIFsgYGV4cHIgJFQgJSAyYCAtZXEg
MCBdOyB0aGVuCglhZGRvdXQgIiAiCmVsc2UKCWFkZG91dCAiTCIKCWVjaG8gIiAqIFNvZnQg
bG9ja3VwIG9jY3VycmVkLiIKZmkKClQ9YGV4cHIgJFQgLyAyYAppZiBbIGBleHByICRUICUg
MmAgLWVxIDAgXTsgdGhlbgoJYWRkb3V0ICIgIgplbHNlCglhZGRvdXQgIksiCgllY2hvICIg
KiBLZXJuZWwgbGl2ZSBwYXRjaGVkLiIKZmkKClQ9YGV4cHIgJFQgLyAyYAppZiBbIGBleHBy
ICRUICUgMmAgLWVxIDAgXTsgdGhlbgoJYWRkb3V0ICIgIgplbHNlCglhZGRvdXQgIlgiCgll
Y2hvICIgKiBBdXhpbGlhcnkgdGFpbnQsIGRlZmluZWQgZm9yIGFuZCB1c2VkIGJ5IGRpc3Ry
b3MuIgpmaQoKVD1gZXhwciAkVCAvIDJgCmlmIFsgYGV4cHIgJFQgJSAyYCAtZXEgMCBdOyB0
aGVuCglhZGRvdXQgIiAiCmVsc2UKCWFkZG91dCAiVCIKCWVjaG8gIiAqIEtlcm5lbCB3YXMg
YnVpbHQgd2l0aCB0aGUgc3RydWN0IHJhbmRvbWl6YXRpb24gcGx1Z2luLiIKZmkKCmVjaG8g
IlJhdyB0YWludCB2YWx1ZSBhcyBpbnQvc3RyaW5nOiAkdGFpbnQvJyRvdXQnIiAKI0VPRiMK

--------------A008BE2F2FE00B944C7960DA--
