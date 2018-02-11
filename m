Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932156AbeBKUc0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 15:32:26 -0500
Received: from omr-m016e.mx.aol.com ([204.29.186.16]:36929 "EHLO
        omr-m016e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeBKUcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 15:32:25 -0500
From: Martin Vuille <jpmv27@aim.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] perf annotate: Don't prepend symfs path to vmlinux path
Date: Sun, 11 Feb 2018 15:32:09 -0500
Message-Id: <20180211203210.12738-1-jpmv27@aim.com>
X-Mailer: git-send-email 2.13.6
x-aol-global-disposition: G
x-aol-sid: 3039ac1d1bce5a80a8556561
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix works for my use case of supplying both '--symfs' and '--vmlinux'
options, and should be harmless if '--symfs' is not specified, but I suspect
it could cause problems if '--symfs' is specified without '--vmlinux', as
the symfs path will no longer be prepended and vmlinux may no longer be found.

Would appreciate any insights on a better approach to fix fix the issue.

Regards,
MV
