Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BC5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D753214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfA2Oak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:30:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:48191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfA2Oak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:30:40 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiDrv-1hT1sH3x7j-00nMpi; Tue, 29
 Jan 2019 15:29:55 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Minghui Liu <minghui.liu.95@gmail.com>,
        Michael Rodin <michael-git@rodin.online>,
        Grigory Shipunov <mail@oxapentane.com>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Stephen Boyd <sboyd@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: Change LXR references to elixir.bootlin.com
Date:   Tue, 29 Jan 2019 15:29:11 +0100
Message-Id: <20190129142923.5743-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RFtztAhG7nP8GfwnhwXEK2KhyRvO70mIOqq7+GF5TmHi+tUlUay
 nZErkbyxFPcQ75a/ZWLcQ8f/bZ1ahlKumvTmgRCnqtil3KbykQSUc4+4m4rkf0aCRbO3D7I
 3t6Gck/jXezZFVIQgOeYu6Se8Yvt3xU0tXgwSbW8Wde4Ko0SQrEbtj9CIHauQ4wol6kdKWo
 ku1M10AevX1bI5kuuAqIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VEI5B0CCF3w=:1zEhRwo9oSPM4WTdGknaxp
 FKcDrT/g4uNGNvQYRosT6P/CCvrLfxiiQJ9TP0FGl1ftiERCEop1r/syea7xgvY3Wyxxaq1ON
 C0LChSgytchGYveNFTVYVkHbWF7aQ0L4GjKW30+xQJ1jYNxssudLUcrXeTS7xLC9xc3XRbVQy
 R94zHJnvMtdKJiidItUCod4C1Y2C6gLKZ/s0+S5wmqMs/iQ45fezY+OhfyygTiiXXSNEmrw+f
 GtCOlTVndgb1btjpCYkuTAnp30AVx2RTsTz9ijaoZpFGW7QjbUX7y4bwTHPBWYmlizG40AHtK
 +hh/LXEsPz+LltgSuCWg+YkYi0PqJPEe3RRVZIoxPN+5zx5+lmED/BGcrWAY/1AZ0ytmxlXYH
 RCoEQwMvE8nxk0myOJe7C5uFrTKr2jpu9qJWy/yOpF0oSEna6Np1knrpvEEK56Ev9Rfq2gLhE
 38vaxzOXhejjpVFRBDgwtA0PvHbb6Os7Ex4bYXDRIyLHVLFpDi9WoEHA+Dy+A5QW02r4lF24P
 J9sobn4CsJv5/WPb/oZSJXMzYJ+ZMrP+5rffzrUVnrT3OZo/gEc/iXTMlI9htEHpnWIakPCyK
 ZZeNJprZAQBv5JnfJ1bUoka2vnTEyK0eAdkRqFdCcEh5ova1wh+M0RDaZgY/dXo/5ff/99YTL
 olpZB4eqUVqEfyDH8CHOnmHPE1vcnLEsPfcfjYXS7VkovrKxAiSrRrnLNYw7r1/CDA4Zk7zr9
 ThOAjbHSlBs/pQDvuo5m/y0UUhEwjkdS8kLC3b1GEmAQJ1vLzpcHKZw2vrppPYrlPvLM/WZTb
 6eWDKnYgdSNYOa6ydtpVxB0qe+0u6aVXF9JmFL+GEB/Oo7jFKrifFGUom4wxgcZJSI4S8bo4n
 NSpKNiJQDAmMl/s+ljwYU9/Z6befZ/59olpKPgHIpYnm+BVLGZRlERZHeHa4x7VR9hj4wkwW+
 hWEzFGSBZfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, Free Electrons was renamed to Bootlin[1]. Less recently, the
Linux Cross Reference (LXR) at lxr.free-electrons.com was replaced by
Elixir[2], and lxr.free-electrons.com redirected first to
elixir.free-electrons.com and now to elixir.bootlin.com.

[1]: https://bootlin.com/blog/free-electrons-becomes-bootlin/
[2]: https://github.com/free-electrons/elixir

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/input/devices/xpad.rst               | 2 +-
 Documentation/process/howto.rst                    | 2 +-
 Documentation/process/kernel-docs.rst              | 2 +-
 Documentation/translations/it_IT/process/howto.rst | 2 +-
 Documentation/translations/ja_JP/howto.rst         | 2 +-
 Documentation/translations/ko_KR/howto.rst         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/input/devices/xpad.rst b/Documentation/input/devices/xpad.rst
index b8bd65962dd8..95d410b27a96 100644
--- a/Documentation/input/devices/xpad.rst
+++ b/Documentation/input/devices/xpad.rst
@@ -218,7 +218,7 @@ References
 .. [1] http://euc.jp/periphs/xbox-controller.ja.html (ITO Takayuki)
 .. [2] http://xpad.xbox-scene.com/
 .. [3] http://www.markosweb.com/www/xboxhackz.com/
-.. [4] http://lxr.free-electrons.com/ident?i=xpad_device
+.. [4] https://elixir.bootlin.com/ident?i=xpad_device
 
 
 Historic Edits
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 58b2f46c4f98..bdd2eda81a1c 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -225,7 +225,7 @@ Cross-Reference project, which is able to present source code in a
 self-referential, indexed webpage format. An excellent up-to-date
 repository of the kernel code may be found at:
 
-	http://lxr.free-electrons.com/
+	https://elixir.bootlin.com/
 
 
 The development process
diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 3fb28de556e4..ab12dddc773e 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -565,7 +565,7 @@ Miscellaneous
 
     * Name: **Cross-Referencing Linux**
 
-      :URL: http://lxr.free-electrons.com/
+      :URL: https://elixir.bootlin.com/
       :Keywords: Browsing source code.
       :Description: Another web-based Linux kernel source code browser.
         Lots of cross references to variables and functions. You can see
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 909e6a55bc43..b323c4b309a5 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -234,7 +234,7 @@ il progetto Linux Cross-Reference, che è in grado di presentare codice
 sorgente in un formato autoreferenziale ed indicizzato. Un eccellente ed
 aggiornata fonte di consultazione del codice del kernel la potete trovare qui:
 
-	http://lxr.free-electrons.com/
+	https://elixir.bootlin.com
 
 
 Il processo di sviluppo
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index f3116381c26b..2ca9389d5915 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -245,7 +245,7 @@ Linux カーネルソースツリーの中に含まれる、きれいにし、
 できます。この最新の素晴しいカーネルコードのリポジトリは以下で見つかり
 ます -
 
-	http://lxr.free-electrons.com/
+	https://elixir.bootlin.com/
 
 開発プロセス
 ------------
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index a8197e072599..9fc869087e9c 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -235,7 +235,7 @@ ReST 마크업을 사용하는 문서들은 Documentation/output 에 생성된
 소스코드를 인덱스된 웹 페이지들의 형태로 보여준다. 최신의 멋진 커널
 코드 저장소는 다음을 통하여 참조할 수 있다.
 
-      http://lxr.free-electrons.com/
+      https://elixir.bootlin.com/
 
 
 개발 프로세스
-- 
2.20.1

