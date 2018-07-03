Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607EAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F336208B1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F336208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=manjaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934445AbeGCRuD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:50:03 -0400
Received: from mail.manjaro.org ([176.9.38.148]:55814 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934187AbeGCRuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:50:02 -0400
X-Greylist: delayed 1127 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2018 13:50:02 EDT
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 533C030E2F8C;
        Tue,  3 Jul 2018 19:32:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X_97Qz5nLl1Z; Tue,  3 Jul 2018 19:32:07 +0200 (CEST)
Subject: Re: Linux 4.4.139
From:   =?UTF-8?Q?Philip_M=c3=bcller?= <philm@manjaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <d4d62b73-d769-c708-8a3c-8b04189ae366@manjaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=philm@manjaro.org; prefer-encrypt=mutual; keydata=
 xsBNBE+lRkIBCADLJUalcQCQKu9I+nxfF08MJSgc0/FSiIRn490B9SgV9AR41AAxjTOFhFtG
 oLo0IxaqQIOpw4OiEwpodpwdYVB2GPI2iX7Gwx5y4T2E12jZQAIYGaPd7Z+nmjPZ+b/+QFeJ
 E6qys1H6Fjq0bTyg029riGUyOls4NSJeOYOVCRmpAlFe2JvfVZ0i39Hbmu7vg90hcnA838ad
 Ic4N+KXliAmsDxtDLKrgvlBmI0JHA/5qUh9MOjT5wh6svE7aQKRDcSh3YOWKGryK+0oyq5oy
 Cx0pt1imzQ79NloEFSU1dhQ7GoxF/EjbW4DAfMFO3y1wg3equ07su9p1qftkA7vha9MrABEB
 AAHNMlBoaWxpcCBNw7xsbGVyIChDYWxsZWQgTGl0dGxlKSA8cGhpbG1AbWFuamFyby5vcmc+
 wsB4BBMBAgAiBQJPpUZCAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDKpqWWEcfw
 fhUtB/44Q2KsYPu4ILbFmE12XJ83j3UIbzVMtIx0mfzVXJCIm0z+OjHEPT3pRwsfW04yibvf
 Tx4mhbE2crn1trZkmQZMRdKN8WfPMkN36owhdEkAOOdwsEzEhkw78w9nv52kySWlldDyLNMf
 V/g4hgoSBb+vrgJKgSANIT/ROZeeUoymmES+d71vnHmYVOGyNu2F/1J7SxJSqotK3PeycN+p
 K67G7ZWwynBuQuIIX9ZnW2ps8HVHxOfjyLQbyXqu+r8HwU42spGGGnNNH9DPe4dAgngppIn+
 eZvCttGCeNwH8FEX6vMSMQ2Z359yX27n/Ed+1WNRKuuUIrHAeHP/w5Q3GhdbzsBNBE+lRkIB
 CAC1FdgvxabizeXdI/0AtgIhmmoY/xaNOsLOITEQVE0OqcDRrRBMYm50+s6d7sWkAGTMXSmb
 NIgPpdR/5V+TlCP7gOdKMHdSSr/0PIjdqZ58hMI1L8la8HT8kvCbJU/V3f1bv81SpzRwyBF4
 9z6S6+05WZwhCovCyjQS9IOtV3rplYw7MzMeFYj413LraXheL/DK1ud4lSSzTTFkjdF2njmt
 6AZGGYgzrQJJ+hKuYcGMLd1QR5xSejR8tsLOaX0SaoKtBkoQE1q1ApFVTbAdYHrqdF4+kgp1
 mJopW/aJ2+QogVT13/BjdUhgj5B5LgQXnbtMmWylcXQP7nQuACjokKsfABEBAAHCwF8EGAEC
 AAkFAk+lRkICGwwACgkQyqallhHH8H6vKggAybxZ4JcUflLmsuYATI6qJUFmlgqcdN2GrTfc
 xMDRRGgHSTPScaXTyy/r17lQqcIHlXi01+E3wAwWKqEjQ0ZezNib5FSf0mtvEIbRGRYwAxK5
 PPMVBVu045U9PJKsdcAj6LbU/50gTqqczGknniNgikjsf6E82Al6rqPKZf35kxbxPi/Dncun
 v31q/xBwNM/NXs8EKcCVncsFmVKYmXi+rDCK/wl8EzNO6XkFX/j5Xi5VYwSoMeKGHbdNMhUP
 24LtwbGhpyogoDSF1ojDhthZlCjfcPYsZTVh2t92G1ugua4Umb8Ycc0JAgiSQw0/VXz4Rilc
 r40odwkjUugPFtZgUg==
Message-ID: <e428c411-8095-d9a3-be7e-995f275b01e5@manjaro.org>
Date:   Tue, 3 Jul 2018 19:32:06 +0200
MIME-Version: 1.0
In-Reply-To: <d4d62b73-d769-c708-8a3c-8b04189ae366@manjaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-LU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

for this kernel there are now patches generated on kernel.org homepage.

Best, Philip

