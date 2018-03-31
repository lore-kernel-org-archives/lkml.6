Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/z1YieyupQoqU7Cj158SC/yw27YU/oU+2whKfouCL7xglWW/Vp96oGfFYjjlxkGmPMFn9Z
ARC-Seal: i=1; a=rsa-sha256; t=1522476589; cv=none;
        d=google.com; s=arc-20160816;
        b=kUNkwIDNPz6/zhruoZ7+EnEMRKkldz3bP4k7PGEg6xvpDzR4ggIcK4n1ocX2n7Aj+C
         86pThJ8EQ1ThYEZHmn0DhDGfnJIz2kqSo9sJ1jV3B1UMcTDfJ5l0Pf7ZROEZwAohxNvz
         QIxEl8e6vSUp46NxRRFK3tcQ+5Z66zIQe5yjxLAWQ+W4yJYk2+76q5DDmLhb+OnosAk1
         AjMFrJLG0HMNL26Sc0MGRG0UYuqfdqtY/MRb4xBJsVNJbTSe4na1cZnY6tlQFSID603R
         lngI/S4iFkyFF+9wHjONRCt1X6RkDfs4nktsSXIbw7azxZA6HSUFdvMkTU7H+hWlKlCz
         vpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8vrYHo9HAu6eoFZXxuAexZXo5VCwkDJv3GxogAkWc6U=;
        b=hHHIG7LrW1ToNcWV3mUwmStP0qitQCQs5ROi8NTsnO9c6HNf3gWK3B1L3JR1WLlKh6
         e1uZR4+xeJPSwVsxD3t3qsmfEWi3qTGCVJ6SH3O9uBThiZbVb9GFdHJ7+JAbCEpOpkxj
         j04jiAM3tmmBdUk7XgTl9y/coHl6/lr8HE4Ay7yic3sHsfiEuHQTIhr9tG/bnSqCXK47
         jHNLSDm9Pv10XqoxSKs9rkA9NetvxbMjYRFF2DOL/UwzQJHgIQPTmYPw4fzi1UVBn93R
         jZ9qqVx3X3MZBDXLB3yEbHmWdwHL3QeEbd7umPhci8dnXzuGKwFrfZVFljOT0EVUr2FK
         mPhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 30/75] staging: ks7010: Remove unused 'struct hostif_stop_confirm_t'.
Date: Fri, 30 Mar 2018 23:08:10 -0700
Message-Id: <20180331060855.9452-30-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:3SfRQJaC20yHdLAI+aZpHrOo1V/6Zd4dVERbO+bwWa1VPFPSr8E
 AsP8swu67WnIYTOz+BHf0AAhrvipVWdxC+5nm+QyHCgisVOqRHYdkpi3AZQElj/mfneD5Vc
 nLxlrvEeF55xZRcaWzVsTqk975ZxmoSRvgoo8BOj/j1i9WvduKRzAX0DAUXx4XeeXILkp8W
 OxHhgSIfWiw/JWmQqGqjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:reKR/N94U3k=:yATa46h9SuowTt2J8vOFXR
 0tdRLyJvNNFQLiopUpT9eleogyJTW2c+aZ2sAbkkiHX5qDvOZEYmJN1I/VKIkCIWLkgyb3Gmo
 aIXdSSQuno1SyHS99hY8m3DvYSM6aXBabR4WQoG+e9CbaDW2fCoRz8T/Zlde4CTaopCXUmfSa
 QTb7RFiszdFFX9oAqADUhNetbyf5LVoLyDv0SG799EZ/YqHkdVwTD3UOmx8jMGB/qN7qeoHNm
 eWL17fteETZaNeyQp+HXeCJBBFERu8m4OVVa3r+/Z5v/j5JVGdhOypZoEXiskviGMgutCQ5i6
 UPDKmrC/qNQSLW+9yhNOBzXv/mouhnEL64gPDjflRqVYD+zBPPon6xT4Fb7MEO+7EOpPcdkc2
 0q02tGli9QU7bfLuF+twBOaXDgtcv0A0JhS63VvPEvHc8L8vEwrEhkrHNHDM68uwgIkLpPOtG
 n/w1V/KXrPnEwJZKE6rdGYe8kgdR+oyce8Bv7r5sAmFGn2ZboqUls7UFcKZt262UUBqaTDpn2
 DKRlhRRiCSlehtFNcq7Bwd0auiEg/vJsm84A5s/PS9Vbm0nABfg6QbnyUveXZz2Gui9b/ZngM
 Up9775Gvb9PxDy8g5FJ4peWcrpq1dr86OC01kNY0qcWyOXyOTyOt6ezim/0NneJaRyDZcWf9K
 K4DG4BAq8kja0rQcpQOLbxKfSJWTMNc2/ODbd6bRWM0n/45RX4H4lz9YOAFsPJIFzxeFXtuGP
 97mmrE3Klg6/7TYMvEthnNAlnZCQX/iaIn7SDg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432412568389713?=
X-GMAIL-MSGID: =?utf-8?q?1596432412568389713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct hostif_stop_confirm_t' is not used in this driver. Remove 'struct
hostif_stop_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index f3c453be9701..52febac0cc60 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -292,11 +292,6 @@ struct hostif_stop_request {
 	struct hostif_hdr header;
 } __packed;
 
-struct hostif_stop_confirm_t {
-	struct hostif_hdr header;
-	__le16 result_code;
-} __packed;
-
 #define D_11B_ONLY_MODE		0
 #define D_11G_ONLY_MODE		1
 #define D_11BG_COMPATIBLE_MODE	2
-- 
2.16.3
