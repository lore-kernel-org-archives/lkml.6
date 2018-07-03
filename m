Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24970C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A06208B1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A06208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=manjaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934457AbeGCRuE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:50:04 -0400
Received: from mail.manjaro.org ([176.9.38.148]:55820 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934309AbeGCRuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:50:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id B527C30E2F04;
        Tue,  3 Jul 2018 19:31:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iLGLcFSU2Q-1; Tue,  3 Jul 2018 19:31:11 +0200 (CEST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Philip_M=c3=bcller?= <philm@manjaro.org>
Subject: Linux 3.18.114
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
Message-ID: <d4d62b73-d769-c708-8a3c-8b04189ae366@manjaro.org>
Date:   Tue, 3 Jul 2018 19:31:11 +0200
MIME-Version: 1.0
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
