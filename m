Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeCZQYm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:24:42 -0400
Received: from mail-dm3nam03on0049.outbound.protection.outlook.com ([104.47.41.49]:65280
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751174AbeCZQYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:24:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v3] Documentation/CodingStyle: Add an example for braces
From: Gary R Hook <gary.hook@amd.com>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net
Date: Mon, 26 Mar 2018 11:24:28 -0500
Message-ID: <152208140376.3661.18214155255662123156.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CO1PR15CA0046.namprd15.prod.outlook.com
 (2603:10b6:101:1f::14) To CY1PR12MB0698.namprd12.prod.outlook.com
 (2a01:111:e400:c43b::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 441288a0-37a1-41d2-c894-08d593361177
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0698;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;3:+BBXmkDnc6q4ddxtWha6e6O6+Vkk6FLE6G4n/xZtWj4vlUS5qWFq5KIoSIe3xYjTnC3ooiWcs2KMjcW9g9BuWWgUVQ3L4pjjuqnD/ejoHniPlebyFG28yQxAVsHevUgBoHiuo7Ss3RlzD/qpGq6f2ArYPeVUvN8w8VPkgM/8Pgp5dSyK/ZxdCAtkYZQPIQZ74lA1baM8G9eZushxLiEg4xqelaGh7WbeMDXmYKDzch/ZTvwH350ylo+cgvaCagMU;25:p5q64tu2HlfEJDtTCeOkGyKXgnKD2I6lJWPbXca39MKKHPVcBpNAgdaACReSv9L1MQsAqcdZbTif7xxPFlTQ0j2jDyjLCt1gyo9NsodL94xMqVOV1fYg+inUYk0KsnuxCDAQVdDLFxXgP+Xgnn1q9nHaz79WwhrGjTBtnf5MEFbc0CQ8gql5mwiJY1O8wSXFu8kRmM/PsxMr8VHvbICKaAyLkMftUMPHDlD9k/FqcbxoE7xzjuPJaoQOQobVOWHArpBj7XrIa9zm7BHWimS12roQs3YS0coJJsdiCZlLCpsFAgM3Sh/dZlR00mlT8Dl8375mcu0OFLVtcYnyVA9Q+w==;31:VugwlvcUvik1Qb9qWnuNXiiKhgNp8LpT6JZdKVJFozC1mUMb9yulC6in6p1ZVxJyfu8qvWTZmSvRhaB92P/CapFRnHpaqRxp0p4J8NO8l4ZqwtnaGULytD5tixfwbqET+dDqHAeiX/tokSOOEYNobtzxKdU8Ru68LgprAffwNYNcb6Af5o9h5sl5MWpAXKBB8ccHLRn+BcKe6GcD4Z/x1lsZ1XaxXsKYERNNu89b790=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0698:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;20:0Uu/g29fRUswRuuj8+TPLS8dBe0uUaaEnBW/9a+Eozvz4ZqGXm/yO2CZqP+a1cjRSFcVA5KyTcOw9HJ/dImb4xl5hTsN5RPxlen4zONcgtRxmJM+iryvZKZniY/RP0u08gp1IxPypLH1ePHsVuUSPBc01kriLg6INvdXepAORoGUyiLMYK9IY/4bozpymgoBT0da/DXNiaKtcOyKRJKESLKKcbkc4lKL7UvUkw4g0WFvuBXjjEAHHlS1hy0yP8K6E7gEuZnVC8FP6pPtVL0twE139DuK4QVA62g3DrT3CdF+zpIXHsXKS+iaoX516vOryD/zu+h+c5JNySrVsARrpTkgQN1gtcXTCaSE689ADFyCyuVu4DriYC+IEP5J0Fk9x/nP72/yzheCCzOru4jm9te4Lwz6IT02AQ3o4pGPlpQ/+vfMkPPh3bm795f4dAsccL2QW1NhMrFAhyvSbQYi+hkfJDCbqvlH77e9B6xEa7DxPKRXMZrdzezuSNt4xqa5;4:pIpK6VmkfR9cCj/r2C6P5l1wqekGGX/0YloVPM5JC3OIUnKPY829Ieo/UIjjYQnxaGO6toGYW8UsnDPfJJ2igo5FLUffSTKbPaQtP3V0q1iitQ67ixqRmfQFBd4z6PZXWr3Z0Jz1AHdTBactTeDl9x9dURcKwetlHZkTAPoXuphd/bC9R1dtRGwIM9ayDhoYRRiqsN+bH8b/1UoRDH3tucJj4Nb/fur8MuQn3AT+sQAuv7iZWdwHjQBqaTwh1EaOK9fULvh2xj3T2wIzZtO4fXSXYL7cj+tfb21Ls8Ar17sBZTvm577QbKYqgM+AbYc6
X-Microsoft-Antispam-PRVS: <CY1PR12MB069852032D184B0B06CCCFB1FDAD0@CY1PR12MB0698.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR12MB0698;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0698;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(39860400002)(366004)(376002)(396003)(39380400002)(346002)(189003)(199004)(72206003)(33896004)(66066001)(47776003)(386003)(25786009)(9686003)(33716001)(105586002)(52116002)(4326008)(478600001)(2486003)(68736007)(956004)(23676004)(26005)(230700001)(6486002)(476003)(6666003)(6916009)(16526019)(5660300001)(86362001)(7736002)(186003)(77096007)(305945005)(53936002)(2361001)(2351001)(97736004)(103116003)(106356001)(16576012)(316002)(8936002)(8676002)(81156014)(81166006)(2906002)(50466002)(58126008)(6116002)(3846002)(486005)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0698;H:[127.0.1.1];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwNjk4OzIzOldIK3NVc2swS095S2xMUTFCRjdrMjNRa3dn?=
 =?utf-8?B?RkQ2V1JscXh6Tmw3OG1BR3pkRFR1L2RkU0VLUGJPUUVWT3c1Kzg5YVlDR2xT?=
 =?utf-8?B?ZnJtczNjQXhoUXVjeTJneVRCWStIaldncjM1WjRrSVhxUzdUMjFlNW1tTmx5?=
 =?utf-8?B?NTFxL1V2bkFZR1JzUXYzSnliVXVnOGpEdHU4aC9kbHRBU3NkYlRtVzcvY0NQ?=
 =?utf-8?B?Q2tXbys1NS94ZmJ5ZGNxR3A0S01URUE5Q255bWJORjhuRUFnQzFFd3pmbUxl?=
 =?utf-8?B?Rmh4dFV1V054alFiKzB0NlEzZFFMQklHZ1VoakFva053S2pQcWhHdG1nNElw?=
 =?utf-8?B?cWFBZENWRno4LzVSdEJaMTFzczNHY2M2NHpmcCtTWnpjQmtiSW5HZjNqVTVL?=
 =?utf-8?B?THZLM0w0VWhtbmZzdDA1YUF0aDNEVmNtaFdzb01kN0hBOFJpSm5GSmsxSkds?=
 =?utf-8?B?eHkvZWF6QzN6K3ArMUhENkljRzU0QmwrQXo4S1JGZTZUVXlxWDRDaWRXSDRr?=
 =?utf-8?B?UDF5WUxwQXh3NUtUaWJkZkRiLzYvczdwSUcyU3UzYlNDNmhTSE1Fb0lpYzRk?=
 =?utf-8?B?S282YzJhQXEyVkNvTkovcmdlYjIybGtGcWxWQ29UK3VSM3ZobGcxeWw1Rnli?=
 =?utf-8?B?YXptRTVSYXlIS3FCemxndDBadEdzMUg1c29sYlVhOE5JdVM2U1hGQ1NodUha?=
 =?utf-8?B?Tk9RMU0xanJXWkdCdXdJa1NSN0p1RC9MNW85M0ZwRWtmL3pBWktkSm5wOVZl?=
 =?utf-8?B?MjRTMlhrQzhzL2Z6dXNEY0xpeC9pVXJzckxLajBxWUdEaENwV1ZwT0oxY0hl?=
 =?utf-8?B?VkhRenBYbE9QTVZ4OXdSZ2JwWTFoMUo4VTZ5bytNb3Q5ZXVSRGo2Zi8vNXMy?=
 =?utf-8?B?SSt3aElpckFqWWNXZExEUmNQSytBa2NydDFrVmJLTGhZOUtWdGtWRE80K3g2?=
 =?utf-8?B?bTVwMGRGUzFnaVI0MHZob2ZwSVluVHdpcktHcU5FblhiQ2RDZGN5alB5aG42?=
 =?utf-8?B?VUpDT0I0eElQVzRnMzduTVY4ZXNSelJVN01EdHY3Y3FsOFJ4dTVGWTNtUW1G?=
 =?utf-8?B?L2RqOU9LMmNmdEpCdkplZjAyQmlkVERiWmFlaC9RWktwVFdNMzJDMUpHdllS?=
 =?utf-8?B?MmtmalRQV1A3SGtoUkQyZFVQRkRMVUVVcGxPUjNRSXlIYUV2anVzRmIvRnZD?=
 =?utf-8?B?RW00OERnVUlWTUpwVGRablhIcDdWVHdleTE0NG5HTmQyVDBYZlYvdHlEbnBW?=
 =?utf-8?B?bkZUcUczUXFQYnhSUGIvWWltOUZrcXh2WmkxeHRDSjBMdG1Dc2VtNDg1M28v?=
 =?utf-8?B?TlJBZDFPQXZoUXJLWnllT0JJRkRYZktQaXlnZ0RpRE8rZ3RPb2N4WE5lZC8v?=
 =?utf-8?B?ZHZMcFdXak9UQi81SCt1T0FlRS9qWlY3R3JzVmlGVENLZFEyNFVqS2VKamR2?=
 =?utf-8?B?bUVxc0R2U2RRUURFVmtVdnB1Tlpra1BzYnhXbTMvVFZDSFJKTmR5UHJRdWNn?=
 =?utf-8?B?TkNmd0lBblV1OWlvYWo0NGdjTXZxYkpIekZhRUpQcTZlYUtObFJCL2w0cWRU?=
 =?utf-8?B?RUo4Rlg0c05jVjZNYVVmdjFDLzNmVnZJVkRHeEVEWjNLVFcyM0RyZ05RSzBu?=
 =?utf-8?B?a2o1QzQxK0owNStHYyt5Nmk5N0R5UFYwbUhIY3JZczR6d3RYSE9lSWxFd1JT?=
 =?utf-8?Q?unHir8Ac4fMJ4a1bbxanMzWAMz0jyHIw6hMglzU?=
X-Microsoft-Antispam-Message-Info: /5KHDKzt11dK6BXvbzeCkJpfRSIMb/rX495glN3vPdyKdJQwEBp3bgeEb9GJsBga0QTQ8ZFWO/aMD1240wf7P/5C6G/dSr2LdLTRl6n8mMj2de/Dj42WELJycrU8BQhklZYzTVA5NaNhVQ7NHaJB1+x6NQgnLLwE4eY3+TycjOj9WAgc9mt46C0qNqI6XEub
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;6:XAOugV7GuMF/mmGquvsvKFRrsNa8wohgoviFsr1zK7rVeIhiYKnweTJDbTMdAhLyC2BpB2qI/Y4/xrNMO4ev1hdG0TlMPdUAPjHy1iYyzEbwwtFtwVO0//lUbfOk6PlRSYldatD4mJZFfF/fjpXlTXnBHYJNYtZ4WbaiG6RyF6Q0OQKSHuPBaYEgjETKXTwehBclZXj01lE6aqueWJszd3EOO4g72Ygu9xeVrEvnHWsthxboEH/VFSDQyTriEul3iOd1DYIwRv+LkpYJ7IPNel4UtYa0sJS+jcWEyYwrqNHZESoQE1gq6CMFIpe5iYrp43Tj0hltD0vghzBYhiBMSvQ2vyioXstBR0I8r2PUSICr1kaxMYCRumJoRz+82SgZVczxWDphdHmbQ1cQ8E+FzgrmV8ZggsX8hNrZcjgXlHmLSLVbdQ2317LFDHy3GiCzKPo41LYIOMPbH0TTsYrgcA==;5:Yr+yKskvL4DLySaKj7J0StsdV+OzwUKvVycQ+TSYhDPnL7kW1a4H+6iByyDBhk+lu90kclQY7FUx0r65ymxNqR2MOYwSnrTIMDFK/QC4/pefHuzn5F1WnnO49qMVnEvOhh4BIg+FE993xOvniXU2vqqIKKZXljuaglyHey/JxTY=;24:E7aq8d3k/+9rLq2bH6mt/t0jM1eM78lm1R6ad/10W4XEftJztlRQuDltabn1kYX8fn9O1jgkLB786cj8FigEBoxXcOGrKzKcP+OHYmKy1hc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;7:9Qr5RzIdFp2yJlOM3a2h6J30bfXt3ocOpt7GKpYqx9qYI5JPDB5e9qdh4H2357pp7kCB/BuigjR2VnsMjDkpzC9gXOgFab9N0+y1J1igTeR77wznxnXvNwbPw7swxZ5TmXnRGINxheW/WnplTiFSf7zfi1xVYrRCtHr8cTJJ9VeUggt5ifywJLf/v+JHSwfVYgR8WjTrkSKloFm1Cjpqme58o7mn8oZRuE1/wz8aXoRrIr+aDeL9BFpfWWjcwrKh;20:7nSaeEe/RLf0ayYmQwoyuI43F98aJDMRhq0ukZhWpd7zvfPnDuOSBZ918NDVgEdyQY3Jmqm2Bc5sISs6qxv8RTHdtacAAhA2P3/sjomGRRbb6UR0gOxx3zLyvmTMaZyqstvbOK6wUJ7od3gyPDq9F2XN6vYBdrY/oatkF/DxUMlmYak6B+YTu6QvuJjRlKSawzsaWkNrMJNIq/QNj8RHH4pTqW56cVl8CFHNvVYDIZQJ1c79/y/wcax8vRwuV+e2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 16:24:36.7122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441288a0-37a1-41d2-c894-08d593361177
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0698
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another example of required braces when using a compound statement in
a loop.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---

Changes since v2:
- Modified the example code fragment

Changes since v1:
- Move the new example up, and make it more generic

 Documentation/process/coding-style.rst |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index a20b44a40ec4..24903244c8be 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -188,6 +188,15 @@ and
 	else
 		do_that();
 
+Do use braces when a body is more complex than a single simple statement:
+
+.. code-block:: c
+
+	if (condition) {
+		while (some_loop_condition)
+			do_something();
+	}
+
 This does not apply if only one branch of a conditional statement is a single
 statement; in the latter case use braces in both branches:
 
