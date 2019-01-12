Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD97C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B4620878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAsPtfVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfALCB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:01:28 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:34071 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfALCB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:01:27 -0500
Received: by mail-yw1-f47.google.com with SMTP id g75so6593415ywb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 18:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+owlNBhxcMEI1HoWDu2zI+LDmhNKuDxzL9bKhO7lqBo=;
        b=VAsPtfVVm9GQcs/a2c+1FFYbwdW10SKlchuTq5Tzu/7PZgi7o/hKyPpSxeyBaRl6xf
         wcSE1g329Op/v0VGQPzvrTxzJFuxQicg0/3iDvkOXajNVc01WwqXGl1o1TbiVxmCABbT
         eIzEGqKiBdMrbRBwNe8d9msAe/7KgoUvg7EL+mhICAAKM3n1tYEWHrNaTdfvKT9i/RAn
         vDSRur5pixSNVqezZFF+AQcOBkxhpHUcj6ZRF6+hSgmWl+cYVwoaByqpu6cDGeU43Mug
         FPPROTSEBdRzK3gilin3vEFap+dN6K46jeTRR5vOBfusVa0JB8IuxooVNIqdBKriYDQv
         iC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+owlNBhxcMEI1HoWDu2zI+LDmhNKuDxzL9bKhO7lqBo=;
        b=CWMhe7Ynyw3sjFyEebyElKOxgru7GfLpf2Z+EJ/pbFcQYPT2FTdhdFYjVvYsdR9Gip
         M7NhMVu23f6dF3IUhI2Bj82Dlp8mQDECcTh19dwk/RimUM2WLl+HdAxp+lmmf/AgGUHy
         CqK4gvgDUcBiiHA4vRzTd/IeehXPnSy3qkftPNkgepj5Eh66HMAVcFuDTVe8/iYiH16B
         5ImTlIEUXKfV7K8kpnQf/w2fzRKMC8U0v4pQL0IRLDathFwassGixTlmsLzINufz2m1a
         nNCcLxILuBMpuxbjY1HE2D/gP8SKOyPH7ycllTWUkfeP6+ZQIEtspMsn5q9hniJsUO5s
         Qq4A==
X-Gm-Message-State: AJcUukeyaUBDhucLqi5LCgoxGzLWZ3jsjbra5IWf4GbiiBymjqU3zvfX
        nL39OjEyFZcBsg6yJY4GUDiJC8YU3zctSjtMDwL8cxY=
X-Google-Smtp-Source: ALg8bN63pxQH39J98FKWBopxtdTtWLi+sEqaLPrKev55VyJ3VFRkyQIqL+pS40dZQxeQyXY4KCD0E4RsbNdxmvVWMZM=
X-Received: by 2002:a81:5113:: with SMTP id f19mr16422105ywb.122.1547258485970;
 Fri, 11 Jan 2019 18:01:25 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Sat, 12 Jan 2019 10:01:08 +0800
Message-ID: <CANnei0HYzfyq15nQnHH6wwYJmcMx1DkzdNNQdxAzE5TBadnpew@mail.gmail.com>
Subject: Good News for 2019 and Beyond: National Neuroscience Institute
 Singapore MRI Brain Scan Stroke Protocol Radiology Report of 29 Dec 2018
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>,
        Turritopsis Dohrnii Teo En Ming <teo.en.ming@gmail.com>,
        teo.en.ming.business@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Good News for 2019 and Beyond: National Neuroscience
Institute Singapore MRI Brain Scan Stroke Protocol Radiology Report of
29 Dec 2018
================================================================================================================================================

National Neuroscience Institute
SingHealth, Singapore

Radiology Report

Patient Name: TEO EN MING

Patient MRN:
Gender: Male
Date of Birth: 1978
Ordering Doctor: YEO ENG HUI DAMIAN (17684B)
Procedure: LIMITED STUDIES (MRA) - NNI

Location:
Exam Date: 29-Dec-2018 03:38
Exam ID: 862664

Main report text:

Examd Id: 862664

REPORT STATUS: APPROVED


LIMITED STUDIES (MRA) of 29-DEC-2018:

REASON FOR EXAM:
Left sided numbness (Correction by Teo En Ming: It is not left sided
numbness. It is tingling sensation on left hand and left leg. And it
is known as paraesthesia.)

REPORT:
Stroke protocol MRI brain was performed. MRI brain dated 1 Sep 2016
was reviewed.

There is no restricted diffusion to suggest an acute infarct.

No abnormal susceptibility is detected to indicate intracranial haemorrhage.

There is no mass effect, hydrocephalus or midline shift. The basal
cisterns are preserved.

The major intracranial arteries demonstrate normal signal voids. Fast
MRA reveals no severe
stenosis or major arterial occlusion in the anterior and posterior circulation.

The imaged paranasal sinuses and mastoid cells are clear.

IMPRESSION:
No acute infarct or intracranial haemorrhage is demonstrated.
No major arterial occlusion or flow limiting stenosis on fast MRA.





Reported by: DR KWOK YING CHRISTINE on 29-DEC-2018 07:19 AM
Approved by: DR JOANNA PEARLY TI on 29-DEC-2018 09:05 AM

Dictated by: Dr Kwok Ying Christine at 29-Dec-2018 07:19
Approved by: Dr Joanna Pearly Ti at 29-Dec-2018 09:05

Verified by: KOAY LEPING (61807A) on 29-Dec-2018 10:47

Printed by: KOAY LEPING on 29-Dec-2018 14:39:52



This is an electronic copy. No signature required.

1 of 1

REFERENCE RESOURCES
======================

Two Redundant Links to Scanned Radiology Report:

[LINK 1] https://tdtemcerts.blogspot.com/2019/01/good-news-for-2019-and-beyond-national.html

[LINK 2] https://tdtemcerts.wordpress.com/2019/01/12/good-news-for-2019-and-beyond-national-neuroscience-institute-singapore-mri-brain-scan-stroke-protocol-radiology-report-of-29-dec-2018/


===BEGIN SIGNATURE===

Turritopsis Dohrnii Teo En Ming's Academic Qualifications as at 30 Oct 2017

[1] https://tdtemcerts.wordpress.com/

[2] http://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

===END SIGNATURE===
