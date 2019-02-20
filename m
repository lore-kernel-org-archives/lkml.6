Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6387FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D29120859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="UwteJitl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfBTXDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:03:22 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:6692 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfBTXDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:03:21 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id D818F1622;
        Thu, 21 Feb 2019 00:03:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1550703796; x=1552518197;
         bh=awqisp93U27JtGUle37gzXlCpLKVu4sJplOAvnhjdS0=; b=UwteJitlk83Z
        pZpOF9aTqQSBiq72u2g75xGn1IvEVMpKkBCSyD60wl7f2hjnXbBrdmZpbGZSABDd
        OoLMoxTUjQPHqopsaZZDzdBtlvKiFzutMu07aHgxf7159AvFmmDLSmGU7RYtsi7N
        wCB01t8iTPCHrs3xrToTRT7hXXQtNbbQHujrRbDz8oMvMu4F8Cs/t/ltZi5R5iUt
        BieZlXr5u9ncBFUjy0aKvsoFPGFC1uR13iIPwgamVmlOzQz2UGvRNGo1+pjIfy9S
        gBOi/eC89mVGcEvj63cgwAM3TMKKVrRutD+igkX4h532qHBzXTlx1s+bmwv4I875
        DP+F9PtaMtE3pH1cRi33qZwpBpATC9Ya07FNAhVO2lthjBU32Q45HyzHzshozy+r
        CscXuE6YjiESfqV/rD6tkY/PaMhXFNne0phiwXvXjRXpaB7+ui00NMZZ1lxC5WKo
        kE7x5NhH9w5zFRhMNKaXy91hzwA/ukAZyMS76/+21eYCA4mBgOXdhutmvPWcZL14
        FfgvAMwyizAHDoVBhqY1QkhcN38OKm6WL3/1sip+BI5zO7hN/9+UMRUSzEBRBCWD
        P/liot4bSFLZLMiFwvY1cmhJ7JNaBTc0FyatjiiU1AuTNa/LuiuEsfRmLstD40Hg
        1lvqs+phLQZ0YIdHhWXbAOlPr1856QQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1dcMKtsbc3dI; Thu, 21 Feb 2019 00:03:16 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id B73C5161A;
        Thu, 21 Feb 2019 00:03:16 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id B31AA226;
        Thu, 21 Feb 2019 00:03:15 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        SeongJae Park <sj38.park@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@zh-kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 1/2] doc: translations: sync translations 'remove info about -git patches'
Date:   Thu, 21 Feb 2019 00:03:04 +0100
Message-Id: <20190220230305.20123-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchonise translations: CN, IT, JP, KR

commit 2c71d305caf9 ("docs: process: Remove outdated info about -git patches")

I can guarantee for the Italian translations, but since we are removing
an entire chapter I think I did it right also for the other languages.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/it_IT/process/howto.rst | 10 ----------
 Documentation/translations/ja_JP/howto.rst         |  8 --------
 Documentation/translations/ko_KR/howto.rst         |  7 -------
 Documentation/translations/zh_CN/HOWTO             |  8 --------
 4 files changed, 33 deletions(-)

diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index f9a44b1af89d..15199aa5b4df 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -313,16 +313,6 @@ Il file Documentation/process/stable-kernel-rules.rst (nei sorgenti) documenta
 quali tipologie di modifiche sono accettate per i sorgenti -stable, e come
 avviene il processo di rilascio.
 
-Le modifiche in 4.x -git
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-Queste sono istantanee quotidiane del kernel di Linus e sono gestite in
-una repositorio git (da qui il nome). Queste modifiche sono solitamente
-rilasciate giornalmente e rappresentano l'attuale stato dei sorgenti di
-Linus. Queste sono da considerarsi più sperimentali di un -rc in quanto
-generate automaticamente senza nemmeno aver dato una rapida occhiata
-per verificarne lo stato.
-
 
 Sorgenti dei sottosistemi del kernel e le loro patch
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 2ca9389d5915..8de41a6ce984 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -319,14 +319,6 @@ Documentation/process/stable-kernel-rules.rst ファイルにはどのような
 類の変更が -stable ツリーに受け入れ可能か、またリリースプロセスがどう
 動くかが記述されています。
 
-4.x -git パッチ
-~~~~~~~~~~~~~~~
-
-git リポジトリで管理されているLinus のカーネルツリーの毎日のスナップ
-ショットがあります。(だから -git という名前がついています)。これらのパッ
-チはおおむね毎日リリースされており、Linus のツリーの現状を表します。こ
-れは -rc カーネルと比べて、パッチが大丈夫かどうかも確認しないで自動的
-に生成されるので、より実験的です。
 
 サブシステム毎のカーネルツリーとパッチ
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 528433932589..d8fc7c31bde9 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -302,13 +302,6 @@ Andrew Morton의 글이 있다.
 파일은 어떤 종류의 변경들이 -stable 트리로 들어왔는지와
 배포 프로세스가 어떻게 진행되는지를 설명한다.
 
-4.x -git 패치들
-~~~~~~~~~~~~~~~
-
-git 저장소(그러므로 -git이라는 이름이 붙음)에는 날마다 관리되는 Linus의
-커널 트리의 snapshot 들이 있다. 이 패치들은 일반적으로 날마다 배포되며
-Linus의 트리의 현재 상태를 나타낸다. 이 패치들은 정상적인지 조금도
-살펴보지 않고 자동적으로 생성된 것이므로 -rc 커널들 보다도 더 실험적이다.
 
 서브시스템 커널 트리들과 패치들
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/translations/zh_CN/HOWTO b/Documentation/translations/zh_CN/HOWTO
index 5f6d09edc9ac..8e7dee80a087 100644
--- a/Documentation/translations/zh_CN/HOWTO
+++ b/Documentation/translations/zh_CN/HOWTO
@@ -240,14 +240,6 @@ kernel.org网站的pub/linux/kernel/v2.6/目录下找到它。它的开发遵循
 版内核接受的修改类型以及发布的流程。
 
 
-2.6.x -git补丁集
-----------------
-Linus的内核源码树的每日快照，这个源码树是由git工具管理的（由此得名）。这
-些补丁通常每天更新以反映Linus的源码树的最新状态。它们比-rc版本的内核源码
-树更具试验性质，因为这个补丁集是全自动生成的，没有任何人来确认其是否真正
-健全。
-
-
 2.6.x -mm补丁集
 ---------------
 这是由Andrew Morton维护的试验性内核补丁集。Andrew将所有子系统的内核源码
-- 
2.20.1

