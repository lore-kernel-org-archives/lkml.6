Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,TVD_SPACE_RATIO
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C177FC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001C72082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MQhb+Qqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001C72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbeKEAuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 19:50:00 -0500
Received: from m12-11.163.com ([220.181.12.11]:38712 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbeKEAuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 19:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=QVC+u
        XdOjxfUREcvycKdXKoedlEVwlKuMtLf8BV6ErE=; b=MQhb+Qqp7QZzpP8cocmp9
        tIixiIMJZPQE+g2NNnske56iqDYPY0oiQrj1eH5FL9X1APaL1FgxPUfPVp9h5Nx6
        +HHxhTI4miWNPMezMpo4an1lx7BWK4nXOBUj36WWqxK4N91TTL26BpjHRyQMx5c8
        x+mvJ+mnZf43cLkHhtWPtU=
Received: from gedba (unknown [111.79.243.248])
        by smtp7 (Coremail) with SMTP id C8CowAAnhm2KEd9bmVsyGw--.51570S2;
        Sun, 04 Nov 2018 23:34:34 +0800 (CST)
From:   "Tsplhg" <es7721077wen@163.com>
To:     "majordomo" <majordomo@vger.kernel.org>
Cc:     chaozang@hotmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-approval@vger.kernel.org
Subject: h94l8l8WeO0m8fU
Message-ID: <201811042334329700976@163.com>
Date:   Sun, 4 Nov 2018 23:34:32 +0800
X-Mailer: Foxmail 6, 10, 201, 20 [cn]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=ypfx782_9291_403312854.791253"
X-Priority: 3
X-CM-TRANSID: C8CowAAnhm2KEd9bmVsyGw--.51570S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIeHqUUUUU
X-Originating-IP: [111.79.243.248]
X-CM-SenderInfo: lhvxljyrqxl4lhq6il2tof0z/xtbBlwr0WVSIaTD9nwAAsX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=ypfx782_9291_403312854.791253
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

MjAyLjUzLjguOTc=

------=ypfx782_9291_403312854.791253
Content-Type: image/jpeg;
	name="Jzskdw6662.jpg"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="Jzskdw6662.jpg"

/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCkbGBYWGDIkJh4pOzQ+PTo0
OThBSV5QQUVZRjg5Um9TWWFkaWppP09ze3Jmel5naWX/2wBDARESEhgVGDAbGzBlQzlDZWVlZWVl
ZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWX/wAARCAAcAn0DASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDpS91L
qN/arcLGBbRtAwjB8tm8wEnP3uVB7Dt6k0kkvhbyyfbLqWA3TRlxEjSxogZSQqpyTIMdD8pB45It
yXGkWepTTTX0MV2yhJFkusYA5A2E4HXPTufU0+KLTr+xeK3kSa3MpdjDMTh92/O5TkHcc9a1Mx2k
XL3enrK5ZiJJE3Mu1iFdlBIwMEgDPA57DpUFxNfG51SC3kUuloj2yhQNrnzByT15UdeP1JnlksdK
jgM0q28ZJjQvIQpJ+Y7iTgk7ScnnOecnllsul31zcXFvPFdPJGI5gs/mLt5wCuSo79u59TQBSaad
LW5aW+1CB7ZfPlSSOBnMe18bSo28kHrk/L2zmtaxjuIrKFLubzrgKPMfAALd8YA49OOlQmwsoLS5
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
UUUAFFFFABRRRQAUUUUAFFFFAH//2Q==

------=ypfx782_9291_403312854.791253--

